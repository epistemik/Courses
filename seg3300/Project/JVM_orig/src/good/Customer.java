package videomachine;

/**
 * Title: Customer.java
 * Description: part of SEG3300 Project
 * Copyright: Mark Sattolo Copyright (c) 2001
 * Company: Applied Logic Technologies
 * @author Mark Sattolo
 * @version 1.0
 */

public class Customer extends User
{
 private boolean adult = false ;
 private double acctBalance ;
 cassetteDB currentRentals = null ;

  public Customer(String name, int pin, int acct) //constructor 1
   { super(name, pin, acct) ; }

  public Customer(String name, int pin, int acct, boolean a) //constructor 2
   {
    super(name, pin, acct) ;
    adult = a ;
   }

  boolean getAdultStatus()
   { return adult ; }

  double getBalance()
   { return acctBalance ; }

  void setBalance(double amount)
   { acctBalance = amount ; }

  cassetteDB getCurrentRentals()
   { return currentRentals ; }

  void rentalUpdate(cassetteDB cdb)
   { currentRentals = cdb ; }

} //class Customer