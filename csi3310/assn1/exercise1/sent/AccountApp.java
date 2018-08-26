/* File: AccountApp.java
Mark Sattolo  428500
CSI 3310  Assn#1, ex#1  */

public class AccountApp
  {
   static Account myAccount ;  // variable for an account

   public static void main(String args[])
     {
      myAccount = new Account() ; // create a new account

      // create 2 provider threads and 2 withdrawer threads
      Provider white = new Provider(myAccount, "White") ;
      Provider brown = new Provider(myAccount, "Brown") ;
      Withdrawer green = new Withdrawer(myAccount, "Green") ;
      Withdrawer black = new Withdrawer(myAccount, "Black") ;

      // start the threads
      white.start() ;
      brown.start() ;
      green.start() ;
      black.start() ;
     }
     
  } // class AccountApp


