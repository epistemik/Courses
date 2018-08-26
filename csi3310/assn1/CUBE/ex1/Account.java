
public class Account
  {
   int balance ;

   Account() // constructor initializes balance
     { balance = 500 ; }


   int getBalance()
     { return balance ; }


   boolean makeDeposit(int deposit)
     {
      if (deposit < 0)
        {
         System.out.println("Amount $" + deposit
                             + " is not valid: cannot deposit a negative amount.") ;
         return false ;
        }
      balance = balance + deposit ;
      return true ;

     } // makeDeposit()


    boolean makeWithdrawal(int withdrawal)
      {
       if (withdrawal < 0)
         {
          System.out.println("Amount $" + withdrawal
                              + " is not valid: cannot withdraw a negative amount.") ;
          return false ;
         }
       if (withdrawal > balance)
         {
          System.out.println("\nAmount $" + withdrawal + " is not valid!") ;
          System.out.println("You may only withdraw funds up to the current balance of $" + balance) ;
          return false ;
         }
       balance = balance - withdrawal ;
       return true ;

      } // makeWithdrawal()

  } // class Account

