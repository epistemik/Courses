package videomachine;

/**
 * Title: RemoteSystem.java
 * Description: part of SEG3300 Project
 * Copyright: Mark Sattolo Copyright (c) 2001
 * Company: Applied Logic Technologies
 * @author Mark Sattolo
 * @version 1.0
 */

public class RemoteSystem
{
 private final static int DBSIZE = 15 ;
 private accountDB myAcctDB ;
 private cassetteDB m1_CassDB ;
 private userDB myUserDB ;

  public RemoteSystem(int id)
   {
    myAcctDB = new accountDB(DBSIZE) ;
    myAcctDB.addAccts() ;
    myUserDB = new userDB(DBSIZE) ;
    myUserDB.addCustomers() ;
    m1_CassDB = new cassetteDB(id, DBSIZE) ;
    m1_CassDB.addFilms() ;
   }

  Account getAccount(Customer c)
   { return myAcctDB.getAccount(c) ; }

  Customer getCustomer(String name)
   {
    // get the customer
    Customer cust = myUserDB.getCustomer(name) ;
    //update the Customer.balance variable to the customer's current Acct balance
    if (cust != null) cust.setBalance(getBalance(cust.getAcctNum())) ;
    return cust ;
   }

  double getBalance(int acctNum) //get the balance in an account
   { return myAcctDB.getBalance(acctNum) ; }

  cassetteDB search(String info)
   { return m1_CassDB.search(info) ; }

  Cassette findCassByCode(String code)
   { return m1_CassDB.findCassByCode(code) ; }

  double rentalUpdate(Customer c, cassetteDB cdb, double amount)
   {
    myUserDB.rentalUpdate(c, cdb) ;
    return myAcctDB.rentalUpdate(c.getAcctNum(), amount) ;
   }

} //class RemoteSystem