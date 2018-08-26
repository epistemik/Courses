/* File: Withdrawer.java
Mark Sattolo  428500
CSI 3310  Assn#1, ex#1  */

public class Withdrawer extends Thread
  {
   Account anAccount ;   // variable for the Account
   int bal, wd ;         // variables for the balance and withdrawal amounts
   boolean success ;     // boolean to test for successful deposit

   Withdrawer(Account acct, String name) // constructor sets the account and its name
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
            // get the balance
            bal = anAccount.getBalance() ;
            // sleep for 20 ms
            sleep(20) ;

            /* withdraw $0 if balance is already $0, else amount from $1 to balance
               - will get an Account error here if attempt to withdraw a non-zero
               amount if the balance is already $0  */
            wd = (bal == 0) ? 0 : 1 + ((int)(Math.random() * bal)) ;
            // try the withdrawal
            success = anAccount.makeWithdrawal(wd) ;

            // > can obtain inconsistent views by putting 'sleep(20);' here
            bal = anAccount.getBalance() ; // get the new balance

            // notify if withdrawal succeeded or not
            if (success)
               System.out.println("Withdrawer " + getName() + " has withdrawn $"
                                   + wd + " and the new balance is $" + bal) ;
            else
               System.out.println("[Withdrawer " + getName() + "]\n") ;

            // sleep from 10 to 40 ms
            sleep(10 + (int)(Math.random() * 31)) ;
           }
         // handle any exceptions
         catch (InterruptedException ie)
             { System.err.println("WithdrawerError: " + ie) ; }
         catch (Exception e)
             { System.err.println("WithdrawerError: " + e) ; }

        }// endwhile

     }// run()

  } // class Withdrawer

