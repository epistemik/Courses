/* File: Owner.java
Mark Sattolo  428500
CSI 3310  Assn#1, ex#2  */

public class Owner extends Thread
  {
   Account[] myAccounts ;    // array for the accounts
   Account source, dest ;    // variables for source & destination account
   int bal, transfer ;       // variables for the balance & transfer amount
   boolean success, success2 ;  // booleans to test if transactions were successful

   Owner(Account[] accts) // constructor sets the accounts
     { myAccounts = accts ; }

   public void run()
     {
      while (true)  // continue forever
        {
         try   // exception handling
           {
            source = myAccounts[(int)(Math.random() * 3)] ;  // set source
            dest = myAccounts[(int)(Math.random() * 3)] ;  // set destination
            // loop until destination is different from source
            while (source == dest) dest = myAccounts[(int)(Math.random() * 3)] ;

            // get the balance
            bal = source.getBalance() ;
            /* calculate the amount to transfer - if balance is already $0 then
               the transfer will be $0, else an amount from $1 to balance */
            transfer = (bal == 0) ? 0 : 1 + ((int)(Math.random() * bal)) ;

            /* > if there were a second owner thread with access to the same accounts,
                 could obtain inconsistent views by putting 'sleep(20);' here */

            // start the transfer with a withdrawal and set the boolean
            success = source.makeWithdrawal(transfer) ;
            if (success)
              {
               sleep(20) ; // sleep 20 ms
               // try the deposit to complete the transfer and set the boolean
               success2 = dest.makeDeposit(transfer) ;
               if (success2) // successful transfer
                  System.out.println("\tOwner has transferred $" + transfer + " from Account "
                                      + source.getName() + " to Account " + dest.getName()) ;
               else // deposit failed
                  System.out.println("[Bad Deposit: Source is Account " + source.getName()
                                       + " & Destination is Account " + dest.getName() + "]\n") ;
              }
            else // withdrawal failed
               System.out.println("[Bad Withdrawal: Source is Account " + source.getName()
                                    + " & Destination is Account " + dest.getName() + "]\n") ;

            // sleep between 10 and 40 ms
            sleep(10 + (int)(Math.random() * 31)) ;
           }
         // catch any exceptions
         catch (InterruptedException ie)
             { System.err.println("OwnerError: " + ie) ; }
         catch (Exception e)
             { System.err.println("OwnerError: " + e) ; }

        }// endwhile

     }// run()

  } // class Owner

