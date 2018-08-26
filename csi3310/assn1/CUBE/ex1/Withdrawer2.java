
public class Withdrawer2 extends Thread
  {
   Account anAccount ;
   int bal, wd ;
   boolean success ;

   Withdrawer2(Account acct, String name) // constructor
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
            this.sleep(20) ;
            bal = anAccount.getBalance() ;
            if (success)
               System.out.println("Withdrawer2 " + getName() + " has withdrawn $"
                                   + wd + " and the new balance is $" + bal) ;
            else
               System.out.println("[Withdrawer2 " + getName() + "]\n") ;
            this.sleep(10 + (int)(Math.random() * 31)) ;
           }
         catch (InterruptedException ie)
             { System.err.println("Withdrawer2Error: " + ie) ; }
         catch (Exception e)
             { System.err.println("Withdrawer2Error: " + e) ; }

        }// endwhile

     }// run()

  } // class Withdrawer2

