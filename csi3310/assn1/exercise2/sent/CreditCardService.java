/* File: CreditCardService.java
Mark Sattolo  428500
CSI 3310  Assn#1, ex#2  */

public class CreditCardService extends Thread
  {
   Owner theOwner ;  // variable for an owner
   int sum ;         // variable to hold the sum

   CreditCardService(Owner personX) // constructor sets the owner
     { theOwner = personX ; }

   public void run()
     {
      while (true) // continue forever
        {
         try   // exception handling
           {
            /* calculate the sum -> can obtain inconsistent views if this instruction
               is interrupted while in the getBalance() method of one of the accounts */
            sum = theOwner.myAccounts[0].getBalance() + theOwner.myAccounts[1].getBalance()
                  + theOwner.myAccounts[2].getBalance() ;

            // compare sum to $280 and notify owner of result
            if (sum >= 280)
               System.out.println("Congratulations! You have total funds of $" + sum
                                   + " and qualify for a new Credit Card.") ;
            else
               System.out.println("\nSorry, but your balance of $" + sum
                                   + " is NOT enough for a new Credit Card!\n") ;

            // sleep from 10 to 40 ms
            sleep(10 + (int)(Math.random() * 31)) ;
           }
         // catch any exceptions
         catch (InterruptedException ie)
             { System.err.println("CCServiceError: " + ie) ; }
         catch (Exception e)
             { System.err.println("CCServiceError: " + e) ; }

        }// endwhile

     }// run()

  } // class CreditCardService

