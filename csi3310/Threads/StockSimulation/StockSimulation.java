/**
 * The FundConstants interface is a container for constants
 * that are shared by all classes.  Any class that needs
 * unqualified access to these names implements the interface
 */
interface FundConstants {
    static final int noOfStocks = 3;
    static final int noOfManagers = 150;
    static final int testDuration = 20;
    static final int randomTransfers = 1000;
    static final int initialBalance = 10000;
    static final int totalMoneyInUniverse = noOfStocks * initialBalance;
}

/**
 * Data class representing a desired stock transfer
 */
class Transfer implements FundConstants {
    final public int fundFrom;
    final public int fundTo;
    final public int amount;

    public Transfer() {
        fundFrom = (int)(Math.random() * noOfStocks);
        fundTo = (int)(Math.random() * noOfStocks);
        amount = (int)(Math.random() * 1000);
    }
}

/**
 * Contains the current value of each stock, plus methods to
 * transfer between stocks and verify that the total value is
 * correct.
 */
class Stocks implements FundConstants {
    static int[] balances = new int[noOfStocks];
    static
    {
        for (int n=0; n<noOfStocks; n++) {
            balances[n] = 10000;
        }
    }

    static void transfer(Transfer t) {
        balances[t.fundFrom] -= t.amount;
        balances[t.fundTo] += t.amount;
    }
    static void checkSystem() {
        int actual = 0;
        for (int n=0; n<noOfStocks; n++) {
            actual += balances[n];
        }
        System.out.println("Actual balance is " + actual);
    }
}

/**
 * The FundManager class simulates fund managers who
 * sleep a lot and move money around at random.
 */
class FundManager implements Runnable, FundConstants {

    final String name;
    long throughput;

    public FundManager(String name) {
        this.name = name;
    }

    public void run() {
        int next = 0;
        while (true) {
            Stocks.transfer(TestFundManagers.transfers[next++]);
            throughput++;
            if (next == randomTransfers)
                next = 0;
            try {
                Thread.sleep(1);
            }
            catch (InterruptedException ie) {
                //System.out.println(name + " is closing for the day");
                return;
            }
        }
    }
}

/**
 * This is the main class of the program. It gives each fund manager
 * a thread and then starts it. The thread alternates between
 * sleeping for a millisecond and making a random stock transfer.
 */
public class TestFundManagers implements FundConstants {

    public static Transfer transfers[] =
    new Transfer[randomTransfers];
    static {
        for (int n=0; n<randomTransfers; n++) {
            transfers[n] = new Transfer();
        }
    }

    public static void main(String [] args) {
        Thread[] threads = new Thread[noOfManagers];
        FundManager[] mgrs = new FundManager[noOfManagers];
        for (int n=0; n<noOfManagers; n++) {
            mgrs[n] = new FundManager("Manager " + n);
            threads[n] = new Thread(mgrs[n]);
     //WARNING! You would rarely call setPriority in production code
     threads[n].setPriority(1 + (int)(Math.random() * 4));
            threads[n].start();
        }
        for (int n=0; n<testDuration; n++) {
            try {
                Thread.sleep(1000);
                Stocks.checkSystem();
            }
            catch (InterruptedException ie) {}
        }
        System.out.println();
        for (int n=0; n<noOfManagers; n++) {
            threads[n].interrupt();
        }
        for (int n=0; n<noOfManagers; n++) {
            try {
  threads[n].join();
         } catch (InterruptedException ie) {}
        }
        long throughput = 0;
        for (int n=0; n<noOfManagers; n++) {
            throughput += mgrs[n].throughput;
        }
        Stocks.checkSystem();
        System.out.println("Total transactions " + throughput);
    }
}

