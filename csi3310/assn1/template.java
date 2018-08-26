
class Account
  {
   int balance ;
   
   Account() // constructor
     {
      balance = 500 ;
     }
     
     
   int getBalance
     {
      return balance ;
     }
    
     
   void makeDeposit(int deposit)
     {
      if (deposit < 0)
        {
         System.out.println("Amount $" + deposit + " is not valid!") ;
         System.out.println("Please use the 'makeWithdrawal' method to remove funds.") ;
        }
      else
        {
         balance = balance + deposit ;
        }
     } // makeDeposit()
    
    
    void makeWithdrawal(int withdrawal)
      {
       if (withdrawal < 0)
         {
          System.out.println("Amount $" + withdrawal + " is not valid!") ;
          System.out.println("Please use the 'makeDeposit' method to add funds.") ;
         }
       else if (withdrawal > balance)
         {
          System.out.println("Amount $" + withdrawal + " is not valid!") ;
          System.out.println("You may only withdraw funds up to the current balance of $" + balance) ;
         }
       else
         {
          balance = balance - withdrawal ;
         }
      } // makeWithdrawal()

  } // class Account


