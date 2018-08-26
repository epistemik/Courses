
public class Withdrawer extends Thread
  {
   Account anAccount ;
   int bal, wd ;
   boolean success ;

   Withdrawer(Account acct, String name) // constructor
     {
      anAccount = acct ;
      setName(name) ;
     }

   public void run()
     {
      while (true)
        {
         try
           {
            bal = anAccount.getBalance() ;
            this.sleep(20) ;
            wd = 1 + ((int)(Math.random() * bal)) ;
            success = anAccount.makeWithdrawal(wd) ;
            //this.sleep(20) ;
            bal = anAccount.getBalance() ;
            if (success)
               System.out.println("Withdrawer " + getName() + " has withdrawn $"
                                   + wd + " and the new balance is $" + bal) ;
            else
               System.out.println("[Withdrawer " + getName() + "]\n") ;
            this.sleep(10 + (int)(Math.random() * 31)) ;
           }
         catch (InterruptedException ie)
             { System.err.println("WithdrawerError: " + ie) ; }
         catch (Exception e)
             { System.err.println("WithdrawerError: " + e) ; }

        }// endwhile

     }// run()

  } // class Withdrawer

