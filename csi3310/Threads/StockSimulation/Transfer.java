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

