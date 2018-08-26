package videomachine;

/**
 * Title: Payment.java
 * Description: part of SEG3300 Project
 * Copyright: Mark Sattolo Copyright (c) 2001
 * Company: Applied Logic Technologies
 * @author Mark Sattolo
 * @version 1.0
 */

import java.util.* ;

public class Payment
{
 private final static long DAY = (long)(1000*60*60*24) ; //1 day in msec
 private final static long RENTALPERIOD = (long)(DAY*4) ; //4 days
 protected RemoteSystem remote ;
 protected Customer customer ;
 protected cassetteDB rentals ;
 protected double charge ;
 protected int start ;
 protected Date now, due ;

  public Payment(RemoteSystem r, Customer c, cassetteDB seln, double $m, int st)
   {
    remote = r ;
    customer = c ;
    rentals = seln ;
    charge = $m ;
    start = st ;
   }

  void setDueDate()
   {
    now = new Date() ;
    due = (Date)now.clone() ;
    long msecs = due.getTime() ;
    due.setTime(msecs + RENTALPERIOD) ;
    rentals.setDueDate(due) ;
   }

  void informDueDate()
   {
    Calendar cal = Calendar.getInstance() ;
    System.out.println("Your cassette or cassettes are due back on " + cal.getTime()) ;
   }

} //class Payment