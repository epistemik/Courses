package videomachine;

/**
 * Title: accountDB.java
 * Description: part of SEG3300 Project
 * Copyright: Mark Sattolo Copyright (c) 2001
 * Company: Applied Logic Technologies
 * @author Mark Sattolo
 * @version 1.0
 */

public class accountDB
{
 private int size = 0 ; //number of items in myAccts
 Account[] myAccts ;

  public accountDB(int limit)
   { myAccts = new Account[limit] ; }

  void addAccts()
   {
    myAccts[0] = new Account(1, 234) ;
    myAccts[1] = new Account(2, 345) ;
    myAccts[2] = new Account(3, 456) ;
    myAccts[3] = new Account(4, 567) ;
    myAccts[4] = new Account(5, 678) ;
    size = 5 ;
   }

  Account getAccount(Customer c)
   {
    for (int i=0; i<size; i++)
       if ( c.getAcctNum() == myAccts[i].getAcctNum() )
         return myAccts[i] ;
    return null ;
   }

  Account getAccount(int acctNum)
   {
    for (int i=0; i<size; i++)
       if ( acctNum == myAccts[i].getAcctNum() )
         return myAccts[i] ;
    return null ;
   }

  double getBalance(int acctNum)
   {
    for (int i=0; i<size; i++)
       if ( acctNum == myAccts[i].getAcctNum() )
         return myAccts[i].getBalance() ;
    return 0.0 ;
   }

  int getIndex(Account a)
   {
    for (int i=0; i<size; i++)
       if ( a.getAcctNum() == myAccts[i].getAcctNum() )
         return i ;
    return -1 ;
   }

  double rentalUpdate(int acctNum, double amount)
   { return getAccount(acctNum).rentalUpdate(amount) ; }

} //class accountDB