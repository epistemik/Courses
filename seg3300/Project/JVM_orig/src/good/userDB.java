package videomachine;

/**
 * Title: userDB.java
 * Description: part of SEG3300 Project
 * Copyright: Mark Sattolo Copyright (c) 2001
 * Company: Applied Logic Technologies
 * @author Mark Sattolo
 * @version 1.0
 */

public class userDB
{
 private int size = 0 ; //number of items in myUsers
 User[] myUsers ;

  public userDB(int limit)
   { myUsers = new User[limit] ; }

  void addCustomers()
   {
    myUsers[0] = new Customer("Bob Probert", 123, 1) ;
    myUsers[1] = new Customer("Marie-Laure Sattolo", 234, 5) ;
    myUsers[2] = new Customer("Thomas Sattolo", 345, 5) ;
    myUsers[3] = new Customer("Louise Robb", 456, 5) ;
    myUsers[4] = new Customer("Mark Sattolo", 567, 5) ;
    myUsers[5] = new Customer("Tu Nguyen", 678, 2) ;
    size = 6 ;
   }

  Customer getCustomer(String name)
   {
    String userName ;
    String lowName = name.toLowerCase() ;
    for (int i=0; i<size; i++)
      {
       userName = myUsers[i].getName().toLowerCase() ;
       if (lowName.equals(userName))
         return (Customer)myUsers[i] ;
      }
    return null ;
   }

  int getIndex(Customer c)
   {
    for (int i=0; i<size; i++)
       if ( c.getName().equals(myUsers[i].getName()) )
         return i ;
    return -1 ;
   }

  void rentalUpdate(Customer c, cassetteDB cdb)
   {
    Customer cust = (Customer)myUsers[getIndex(c)] ;
    cust.rentalUpdate(cdb) ;
   }

} //class userDB