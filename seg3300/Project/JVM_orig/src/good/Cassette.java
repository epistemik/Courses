package videomachine;

/**
 * Title: Cassette.java
 * Description: part of SEG3300 Project
 * Copyright: Mark Sattolo Copyright (c) 2001
 * Company: Applied Logic Technologies
 * @author Mark Sattolo
 * @version 1.0
 */

import java.util.Date ;

public class Cassette
{
 protected String ID ;
 protected String title ;
 protected double cost ;
 protected boolean adult = true ;
 protected Date dueDate = null ;

  public Cassette(String i, String t, double c) // constructor 1
   {
    ID = i ;
    title = t ;
    cost = c ;
   }

  public Cassette(String i, String t, double c, boolean a) // constructor 2
   {
    ID = i ;
    title = t ;
    cost = c ;
    adult = a ;
   }

  String getTitle()
   { return title ; }

  double getCost()
   { return cost ; }

  String getCode()
   { return ID ; }

  String getType()
   {
    char id = ID.charAt(0) ;
    if ((id == 'F') || (id == 'f')) return "Film" ;
    if ((id == 'G') || (id == 'g')) return "Game" ;
    return "ERROR" ;
   }

  Date getDueDate()
   { return dueDate ; }

  void setDueDate(Date d)
   { dueDate = d ; }

} //class Cassette