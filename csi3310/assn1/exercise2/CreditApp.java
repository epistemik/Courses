/* File: CreditApp.java
Mark Sattolo  428500
CSI 3310  Assn#1, ex#2  */

public class CreditApp
  {
   static Account[] someAccounts ;  // an array of accounts

   public static void main(String args[])
     {
      final int number = 3 ; // the number of accounts

      // initialize the array
      someAccounts = new Account[number] ;
      for (int i = 0; i < number; i++)
         // initialize the individual accounts
         someAccounts[i] = new Account(Integer.toString(i)) ;

      // create a new Owner thread
      Owner cardOwner = new Owner(someAccounts) ;
      // create a new CreditCardService thread
      CreditCardService myCard = new CreditCardService(cardOwner) ;

      // start the threads
      cardOwner.start() ;
      myCard.start() ;
     }

  } // class CreditApp

