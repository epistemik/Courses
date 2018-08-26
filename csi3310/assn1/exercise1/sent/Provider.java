/* File: Provider.java
Mark Sattolo  428500
CSI 3310  Assn#1, ex#1  */

public class Provider extends Thread
  {
   Account anAccount ;  // variable for the Account
   int dep, bal ;       // variables for the deposit and balance amounts
   boolean success ;    // boolean to test for successful deposit

   Provider(Account acct, String name) // constructor sets the account and name
     {
      anAccount = acct ;
      setName(name) ;
     }

   public void run()
     {
      while (true)  // continue forever
        {
         try   // exception handling
           {
            // calculate a deposit amount between $1 and $100
            dep = 1 + (int)((Math.random() * 100)) ;
            // boolean checks if deposit succeeded
            success = anAccount.makeDeposit(dep) ;

            // > can obtain inconsistent views by putting 'sleep(20);' here
            bal = anAccount.getBalance() ;  // get the balance

            // notify if success or failure of deposit
            if (success)
               System.out.println("Provider " + getName() + " has made a deposit of $"
                                   + dep + " and the new balance is $" + bal) ;
            else
               System.out.println("[Provider " + getName() + "]\n") ;

            // sleep from 10 to 40 ms
            sleep(10 + (int)(Math.random() * 31)) ;
           }
         // handle any exceptions
         catch (InterruptedException ie)
             { System.err.println("ProviderError: " + ie) ; }
         catch (Exception e)
             { System.err.println("ProviderError: " + e) ; }

        }// endwhile

     }// run()

  } // class Provider

