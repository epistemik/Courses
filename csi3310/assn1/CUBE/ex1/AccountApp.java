
public class AccountApp
  {
   static Account myAccount ;
   
   public static void main(String args[])
     {
      myAccount = new Account() ;
      Provider white = new Provider(myAccount, "White") ;
      Provider brown = new Provider(myAccount, "Brown") ;
      Withdrawer green = new Withdrawer(myAccount, "Green") ;
      Withdrawer black = new Withdrawer(myAccount, "Black") ;
      white.start() ;
      brown.start() ;
      green.start() ;
      black.start() ;
     }
     
  } // class AccountApp


