package videomachine;

/**
 * Title: Transaction.java
 * Description: part of SEG3300 Project
 * Copyright: Mark Sattolo Copyright (c) 2001
 * Company: Applied Logic Technologies
 * @author Mark Sattolo
 * @version 1.0
 */

public class Transaction
{
 protected RemoteSystem remote ;
 protected Customer customer ;

  public Transaction(RemoteSystem r, Customer c)
   {
    remote = r;
    customer = c ;
   }

} //class Transaction