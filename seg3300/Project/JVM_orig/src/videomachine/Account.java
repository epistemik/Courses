package videomachine;

/**
 * Title: Account.java
 * Description: part of SEG3300 Project
 * Copyright: Mark Sattolo Copyright (c) 2001
 * Company: Applied Logic Technologies
 * @author Mark Sattolo
 * @version 1.0
 */

public class Account
{
 private int acctNum ;
 private double balance ;

  public Account(int num, double amount)
   {
    acctNum = num ;
    balance = amount ;
   }

  int getAcctNum()
   { return acctNum ; }

  double getBalance()
   { return balance ; }
   
  double rentalUpdate(double amount)
   {
    balance -= amount ;
    return balance ;
   }

} //class Account