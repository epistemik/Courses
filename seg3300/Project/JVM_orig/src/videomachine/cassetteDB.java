package videomachine;

/**
 * Title: cassetteDB.java
 * Description: part of SEG3300 Project
 * Copyright: Mark Sattolo Copyright (c) 2001
 * Company: Applied Logic Technologies
 * @author Mark Sattolo
 * @version 1.0
 */

import java.util.Date ;

public class cassetteDB
{
 private int ID = 0 ;   // default == non-machine DB
 private int size = 0 ; // number of items in myCassettes
 Cassette[] myCassettes ;

  public cassetteDB(int limit) //constructor 1
   { myCassettes = new Cassette[limit] ; }

  public cassetteDB(int i, int limit) //constructor 2
   { ID = i ;
     myCassettes = new Cassette[limit] ; }

  int getSize()
   { return size ; }

  void addFilms()
   {
    myCassettes[0] = new Film("F100", "The Bicycle Thief", 4.95, "Enzo Staiola Elena Altieri", "Vittorio DeSica") ;
    myCassettes[1] = new Film("F101", "Rules of the Game", 5.95, "Marcel Dalio Nora Gregor", "Jean Renoir") ;
    myCassettes[2] = new Film("F102", "Winter Kills", 3.95, "Jeff Bridges Belinda Bauer", "William Richert") ;
    myCassettes[3] = new Film("F103", "The 4th Man", 6.25, "Jeroen Krabbe Renee Soutendijk", "Paul Verhoeven") ;
    myCassettes[4] = new Film("F104", "The Seven Samurai", 3.75, "Toshiro Mifune Minoru Chiaki", "Akira Kurosawa") ;
    myCassettes[5] = new Film("F105", "The Graduate", 2.95, "Dustin Hoffman Anne Bancroft", "Mike Nicholls") ;
    myCassettes[6] = new Film("F106", "Casanova", 5.75, "Donald Sutherland", "Federico Fellini") ;
    myCassettes[7] = new Film("F107", "Through a Glass Darkly", 6.95, "Harriet Andersson Gunnar Bjornstrand", "Ingmar Bergman") ;
    myCassettes[8] = new Film("F108", "Viridiana", 7.25, "Silvia Pinal Fernando Rey", "Luis Bunuel") ;
    myCassettes[9] = new Film("F109", "2001 A Space Odyssey", 3.25, "Keir Dullea Gary Lockwood", "Stanley Kubrick") ;
    size = 10 ;
   }

  void addCassette(Cassette c)
   {
    if (size == myCassettes.length)
      System.out.println("Cassette DB is full.");
    else
       { myCassettes[size] = c ;
         size++ ; }
   }

  Cassette getLast()
   {
    if (size > 0)
      return myCassettes[size-1] ;
    return null ;
   }

  void removeLast()
   {
    if (size > 0)
      { myCassettes[size-1] = null ;
        size-- ; }
   }

  Cassette getCassetteByIndex(int position)
   {
    if (position < size)
      return myCassettes[position] ;
    System.out.println("No cassette at position " + position) ;
    return null ;
   }

  Cassette getCassetteByTitle(String s)
   {
    for (int i=0; i<size; i++)
       if ( s.equals(myCassettes[i].getTitle()) )
         return myCassettes[i] ;
    return null ;
   }

  Cassette findCassByCode(String code)
   {
    String lowCode = code.toLowerCase() ;
    for (int i=0; i<size; i++)
      {
       String dbCassCode = myCassettes[i].getCode().toLowerCase() ;
       if ( dbCassCode.equals(lowCode) )
         return myCassettes[i] ;
      }
    return null ;
   }

  cassetteDB search(String info)
   {
    String lowInfo = info.toLowerCase() ;
    cassetteDB results = new cassetteDB(12) ;
    for (int i=0,j=0; i<size && j<results.myCassettes.length; i++)
      { //search titles for info string
       String title = myCassettes[i].getTitle().toLowerCase() ;
       if ( title.indexOf(lowInfo) >= 0 )
         { results.myCassettes[j] = myCassettes[i] ;
           results.size++ ;
           j++ ; }
       else if (myCassettes[i].getType() == "Film") //if a film
          { //search actors if string not found in title
           String actors = ((Film)myCassettes[i]).getActors().toLowerCase();
           if ( actors.indexOf(lowInfo) >= 0 )
             { results.myCassettes[j] = myCassettes[i] ;
               results.size++ ;
               j++ ; }
           else
             { //search director if string not found in actors
              String director = ((Film)myCassettes[i]).getDirector().toLowerCase();
              if ( director.indexOf(lowInfo) >= 0 )
                { results.myCassettes[j] = myCassettes[i] ;
                  results.size++ ;
                  j++ ; }
             }//end else
          }//end else if
      }//endfor
    return results ;
   }

  void setDueDate(Date d)
   {
    for (int i=0; i<size; i++)
       if ( myCassettes[i].getDueDate() != null )
         myCassettes[i].setDueDate(d) ;
   }

} //class cassetteDB