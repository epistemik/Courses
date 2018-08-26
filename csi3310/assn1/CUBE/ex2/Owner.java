
public class Owner extends Thread
  {
   Account[] myAccounts ;
   Account source, dest ;
   int bal, transfer ;
   boolean success, success2 ;

   Owner(Account[] accts) // constructor initializes accounts
     { myAccounts = accts ; }

   public void run()
     {
      while (true)
        {
         try
           {
            source = myAccounts[(int)(Math.random() * 3)] ;
            dest = myAccounts[(int)(Math.random() * 3)] ;
            while (source == dest) dest = myAccounts[(int)(Math.random() * 3)] ;
            bal = source.getBalance() ;
            transfer = (bal == 0) ? 0 : 1 + ((int)(Math.random() * bal)) ;
            success = source.makeWithdrawal(transfer) ;
            if (success)
              {
               this.sleep(20) ;
               success2 = dest.makeDeposit(transfer) ;
               if (success2)
                  System.out.println("\tOwner has transferred $" + transfer + " from Account "
                                      + source.getName() + " to Account " + dest.getName()) ;
               else
                  System.out.println("[Bad Deposit: Source is Account " + source.getName()
                                       + " & Destination is Account " + dest.getName() + "]\n") ;
              }
            else
               System.out.println("[Bad Withdrawal: Source is Account " + source.getName()
                                    + " & Destination is Account " + dest.getName() + "]\n") ;
            this.sleep(10 + (int)(Math.random() * 31)) ;
           }
         catch (InterruptedException ie)
             { System.err.println("OwnerError: " + ie) ; }
         catch (Exception e)
             { System.err.println("OwnerError: " + e) ; }

        }// endwhile

     }// run()

  } // class Owner

