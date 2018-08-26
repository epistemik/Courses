package videomachine;

/**
 * Title: cashPayment.java
 * Description: part of SEG3300 Project
 * Copyright: Mark Sattolo Copyright (c) 2001
 * Company: Applied Logic Technologies
 * @author Mark Sattolo
 * @version 1.0
 */

public class cashPayment extends Payment
{
  public cashPayment(RemoteSystem r, Customer c, cassetteDB seln, double $m, int st)
   { super(r, c, seln, $m, st) ; }

  int pay()
   {
    System.out.println("You have selected cassettes: ") ;
    for (int i=0,j=1; i<rentals.getSize(); i++,j++)
       System.out.println(j + "." + rentals.getCassetteByIndex(i).getTitle()) ;
    System.out.println("The total charge for this session is $" + charge) ;

//    System.out.println("Your new account balance is $" + newAcctBal) ;
    System.out.println("Thank you for using 24-hour Video & Game. Please take your cassette, receipt, and card.") ;
    System.out.println("Your cassette or cassettes are due back on April 11, 2001") ;
    return 1 ;
   }

} //class cashPayment