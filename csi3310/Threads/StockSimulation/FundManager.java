
/**
 * The FundManager class simulates fund managers who
 * sleep a lot and move money around at random.
 */
class FundManager implements Runnable, FundConstants {

    final String name;
    long throughput;

    public FundManager(String name) { this.name = name; }

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

