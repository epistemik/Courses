
/**
 * This is the main class of the program. It gives each fund manager
 * a thread and then starts it. The thread alternates between
 * sleeping for a millisecond and making a random stock transfer.
 */
public class TestFundManagers implements FundConstants {

    public static Transfer transfers[] = new Transfer[randomTransfers];
    static {
        for (int n=0; n<randomTransfers; n++) { transfers[n] = new Transfer(); }
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
                Thread.sleep(100);
                Stocks.checkSystem();
            }
            catch (InterruptedException ie) {}
        }

        System.out.println();
        for (int n=0; n<noOfManagers; n++) { threads[n].interrupt(); }
        for (int n=0; n<noOfManagers; n++) {
            try {
                 threads[n].join();
         } catch (InterruptedException ie) {}
        }

        long throughput = 0;
        for (int n=0; n<noOfManagers; n++) { throughput += mgrs[n].throughput; }
        Stocks.checkSystem();
        System.out.println("Total transactions " + throughput);
    }
}

