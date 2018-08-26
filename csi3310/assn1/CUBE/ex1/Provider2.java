
public class Provider2 extends Thread
  {
   Account anAccount ;
   int dep, bal ;
   boolean success ;

   Provider2(Account acct, String name) // constructor
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
            dep = 1 + (int)((Math.random() * 100)) ;
            success = anAccount.makeDeposit(dep) ;
            this.sleep(20) ;
            bal = anAccount.getBalance() ;
            if (success)
               System.out.println("Provider2 " + getName() + " has made a deposit of $"
                                   + dep + " and the new balance is $" + bal) ;
            else
               System.out.println("[Provider2 " + getName() + "]\n") ;
            this.sleep(10 + (int)(Math.random() * 31)) ;
           }
         catch (InterruptedException ie)
             { System.err.println("Provider2Error: " + ie) ; }
         catch (Exception e)
             { System.err.println("Provider2Error: " + e) ; }

        }// endwhile

     }// run()

  } // class Provider2

