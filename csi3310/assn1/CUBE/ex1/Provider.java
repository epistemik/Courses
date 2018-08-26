
public class Provider extends Thread
  {
   Account anAccount ;
   int dep, bal ;
   boolean success ;

   Provider(Account acct, String name) // constructor
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
            // this.sleep(20) ;
            bal = anAccount.getBalance() ;
            if (success)
               System.out.println("Provider " + getName() + " has made a deposit of $"
                                   + dep + " and the new balance is $" + bal) ;
            else
               System.out.println("[Provider " + getName() + "]\n") ;
            this.sleep(10 + (int)(Math.random() * 31)) ;
           }
         catch (InterruptedException ie)
             { System.err.println("ProviderError: " + ie) ; }
         catch (Exception e)
             { System.err.println("ProviderError: " + e) ; }

        }// endwhile

     }// run()

  } // class Provider

