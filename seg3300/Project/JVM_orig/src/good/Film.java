package videomachine;

/**
 * Title: Film.java
 * Description: part of SEG3300 Project
 * Copyright: Mark Sattolo Copyright (c) 2001
 * Company: Applied Logic Technologies
 * @author Mark Sattolo
 * @version 1.0
 */

public class Film extends Cassette
{
 private String actors ;
 private String director ;

  public Film(String id, String name, double price)
   { super(id, name, price) ; }

  public Film(String i, String n, double p, String a, String d)
   {
    super(i, n, p) ;
    actors = a ;
    director = d ;
   }

  String getActors()
   { return actors ; }

  String getDirector()
   { return director ; }

} //class Film