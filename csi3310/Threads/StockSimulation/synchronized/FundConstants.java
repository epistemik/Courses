/**
 * The FundConstants interface is a container for constants
 * that are shared by all classes.  Any class that needs
 * unqualified access to these names implements the interface
 */
interface FundConstants {
    static final int noOfStocks = 3;
    static final int noOfManagers = 150;
    static final int testDuration = 30;
    static final int randomTransfers = 1000;
    static final int initialBalance = 10000;
    static final int totalMoneyInUniverse = noOfStocks * initialBalance;
}

