/*
File: Drawings.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

public class Drawings
{
 private int index,      // index to the current contest submission
             capacity ;  // total drawings to be entered in the contest

 private String[] submissions ; /* array of Strings to store the artist name
                                   for each contest entry.  */

 Drawings( int numEntries ) // constructor
  {
   // set the number of entries and initialize the array
   capacity = numEntries ;
   submissions = new String[ numEntries ] ;
   index = 0 ;
  }

 synchronized int submit( String artistName )
  {
   // assign the artist's name to an entry in the array and print message
   submissions[index] = artistName ;
   System.out.println( artistName + " has handed in drawing #" + index ) ;

   // increment the index
   index++ ;

   // notify when the array of entries is full
   if( index >= capacity )
     notify() ;

   // return the index of the entry that was just handed in (before incrementing)
   return index-1 ;
  }

 // test if all the expected contest entries have been handed in
 synchronized void full()
  {
   if( index < capacity )
    {
     // wait until the contest array is full
     try { wait() ; }

     catch( Exception e )
         { System.err.println( "Drawings.full() Error: " + e ) ; }
    }
  }

 // choose the contest entry at the selected position of the array
 String choose( int select )
  { return submissions[select] ; }


}
// class Drawings
