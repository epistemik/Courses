package videomachine;

/**
 * Title: creditPayment.java
 * Description: part of SEG3300 Project
 * Copyright: Mark Sattolo Copyright (c) 2001
 * Company: Applied Logic Technologies
 * @author Mark Sattolo
 * @version 1.0
 */

public class creditPayment extends Payment
{
  public creditPayment(RemoteSystem r, Customer c, cassetteDB seln, double $m, int st)
   { super(r, c, seln, $m, st) ; }

  int pay()
   {
    System.out.println("\nYou selected cassettes: ") ;
    for (int i=start; i<rentals.getSize(); i++)
       System.out.println(rentals.getCassetteByIndex(i).getTitle()) ;
    System.out.println("The total charge for this session is $" + charge) ;
    setDueDate() ;
    double newAcctBal = remote.rentalUpdate(customer, rentals, charge) ;
    System.out.println("\nYour new account balance is $" + newAcctBal) ;
    System.out.println("Thank you for using 24-hour Video & Game.\nPlease take your cassette, receipt, and card.") ;
    informDueDate() ;
    return 1 ;
   }

} //class creditPayment