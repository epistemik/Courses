/* File: Account.java
Mark Sattolo  428500
CSI 3310  Assn#1, ex#2  */

public class Account
  {
   int balance ;    // variables for balance and name
   String myName ;

   Account(String name) // constructor initializes balance and sets name
     {
      balance = 100 ;
      myName = name ;
     }

   String getName()  // get the account name
     { return myName ; }

   int getBalance()  // get current balance
     { return balance ; }

   boolean makeDeposit(int deposit)
     {
      if (deposit < 0) // check for a valid deposit amount
        {
         System.out.println("Amount $" + deposit
                             + " is not valid: cannot deposit a negative amount.") ;
         return false ; // deposit did not occur
        }
      balance = balance + deposit ; // if deposit is good, amend the balance
      return true ;                 // and return true

     } // makeDeposit()


    boolean makeWithdrawal(int withdrawal)
      {
       if (withdrawal < 0)  // check for a valid withdrawal amount
         {
          System.out.println("Amount $" + withdrawal
                              + " is not valid: cannot withdraw a negative amount.") ;
          return false ;  // withdrawal amount not good
         }
       if (withdrawal > balance)  // make sure withdrawal is less than or equals balance
         {
          System.out.println("\nAmount $" + withdrawal + " is not valid!") ;
          System.out.println("You may only withdraw funds up to the current balance of $" + balance) ;
          return false ;  // withdrawal did not take place
         }
       balance = balance - withdrawal ; // if withdrawal is good, amend balance
       return true ;                    // and return true

      } // makeWithdrawal()

  } // class Account

