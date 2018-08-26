
public class CreditCardService extends Thread
  {
   Owner theOwner ;
   int sum ;

   CreditCardService(Owner personX) // constructor
     { theOwner = personX ; }

   public void run()
     {
      while (true)
        {
         try
           {
            sum = theOwner.myAccounts[0].getBalance() + theOwner.myAccounts[1].getBalance()
                  + theOwner.myAccounts[2].getBalance() ;
            if (sum >= 280)
               System.out.println("Congratulations! You have total funds of $" + sum
                                   + " and qualify for a new Credit Card.") ;
            else
               System.out.println("\nSorry, but your balance of $" + sum
                                   + " is NOT enough for a new Credit Card!\n") ;
            this.sleep(10 + (int)(Math.random() * 31)) ;
           }
         catch (InterruptedException ie)
             { System.err.println("CCServiceError: " + ie) ; }
         catch (Exception e)
             { System.err.println("CCServiceError: " + e) ; }

        }// endwhile

     }// run()

  } // class CreditCardService

