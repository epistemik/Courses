
public class CreditApp
  {
   static Account[] someAccounts ;

   public static void main(String args[])
     {
      int number ;
      if (args.length > 0) number = Integer.parseInt(args[0]) ;
      else number = 3 ;

      someAccounts = new Account[number] ;
      for (int i = 0; i < number; i++)
         someAccounts[i] = new Account(Integer.toString(i)) ;

      Owner cardOwner = new Owner(someAccounts) ;
      CreditCardService myCard = new CreditCardService(cardOwner) ;

      cardOwner.start() ;
      myCard.start() ;
     }
     
  } // class CreditApp


