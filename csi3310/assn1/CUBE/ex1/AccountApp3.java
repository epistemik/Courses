
public class AccountApp3
  {
   static Account myAccount ;
   
   public static void main(String args[])
     {
      myAccount = new Account() ;
      Provider white = new Provider(myAccount, "White") ;
      Provider brown = new Provider(myAccount, "Brown") ;
      Withdrawer2 green = new Withdrawer2(myAccount, "Green2") ;
      Withdrawer2 black = new Withdrawer2(myAccount, "Black2") ;
      white.start() ;
      brown.start() ;
      green.start() ;
      black.start() ;
     }
     
  } // class AccountApp3


