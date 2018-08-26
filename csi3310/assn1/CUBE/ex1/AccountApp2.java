
public class AccountApp2
  {
   static Account myAccount ;
   
   public static void main(String args[])
     {
      myAccount = new Account() ;
      Provider2 white = new Provider2(myAccount, "White2") ;
      Provider2 brown = new Provider2(myAccount, "Brown2") ;
      Withdrawer green = new Withdrawer(myAccount, "Green") ;
      Withdrawer black = new Withdrawer(myAccount, "Black") ;
      white.start() ;
      brown.start() ;
      green.start() ;
      black.start() ;
     }
     
  } // class AccountApp2


