package videomachine;

/**
 * Title: User.java
 * Description: part of SEG3300 Project
 * Copyright: Mark Sattolo Copyright (c) 2001
 * Company: Applied Logic Technologies
 * @author Mark Sattolo
 * @version 1.0
 */

public class User
{
 protected String name ;
 protected int account ;
 protected int PIN ;
 protected boolean privileges = false ;

  public User(String name, int pin, int acct)
   {
    this.name = name ;
    PIN = pin ;
    account = acct ;
   }

  int getAcctNum()
   { return account ; }

  String getName()
   { return name ; }

  int getPIN()
   { return PIN ; }

} //class User