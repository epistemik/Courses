
/**
 * Contains the current value of each stock, plus methods to
 * transfer between stocks and verify that the total value is
 * correct.
 */
class Stocks implements FundConstants {
    static int[] balances = new int[noOfStocks];
    static
    {
        for (int n=0; n<noOfStocks; n++) { balances[n] = 10000; }
    }

    static void transfer(Transfer t) {
        balances[t.fundFrom] -= t.amount;
        balances[t.fundTo] += t.amount;
    }
    static void checkSystem() {
        int actual = 0;
        for (int n=0; n<noOfStocks; n++) { actual += balances[n];  }
        System.out.println("Actual balance is " + actual);
    }
}

