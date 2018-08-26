/* File: Account.java
Mark Sattolo  428500
CSI 3310  Assn#1, ex#1  */

public class Account
  {
   int balance ;  // variable to store the balance

   Account() // constructor initializes the balance
     { balance = 500 ; }


   int getBalance()   // get the balance
     { return balance ; }


   boolean makeDeposit(int deposit)
     {
      if (deposit < 0) // check for a valid deposit
        {
         System.out.println("Amount $" + deposit
                             + " is not valid: cannot deposit a negative amount.") ;
         return false ; // deposit failed
        }
      balance = balance + deposit ; // amend balance if deposit is good
      return true ;                 // and return true

     } // makeDeposit()


    boolean makeWithdrawal(int withdrawal)
      {
       if (withdrawal < 0) // check the withdrawal amount
         {
          System.out.println("Amount $" + withdrawal
                              + " is not valid: cannot withdraw a negative amount.") ;
          return false ;  // withdrawal no good
         }
       if (withdrawal > balance) // check that withdrawal not more than balance
         {
          System.out.println("\nAmount $" + withdrawal + " is not valid!") ;
          System.out.println("You may only withdraw funds up to the current balance of $" + balance) ;
          return false ;  // withdrawal failed as was greater than balance
         }
       balance = balance - withdrawal ;  // amend balance if withdrawal was good
       return true ;                     // and return true

      } // makeWithdrawal()

  } // class Account

