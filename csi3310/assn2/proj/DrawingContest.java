/*
File: DrawingContest.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

class DrawingContest
{
 // constants for the number of drawings and the number of pencils of each color
 private final static int NUM_DRAWINGS = 100,
                          NUM_PENCILS = 3 ;

 public static void main( String[] args )
  {
   // initialize the Semaphore, Paper, and Drawings objects
   ColorSemaphore signal = new ColorSemaphore( NUM_PENCILS );
   Drawings draw = new Drawings( NUM_DRAWINGS );
   Paper papers = new Paper( NUM_DRAWINGS );

   // create the five artists
   Artist art1 = new Artist( signal, papers, draw, "Betty"    );
   Artist art2 = new Artist( signal, papers, draw, "Edith"    );
   Artist art3 = new Artist( signal, papers, draw, "Margot"   );
   Artist art4 = new Artist( signal, papers, draw, "Ruth"     );
   Artist art5 = new Artist( signal, papers, draw, "Victoria" );

   // create the Jury thread
   Jury juror = new Jury( papers, draw, NUM_DRAWINGS );

   // start the artist threads
   art1.start() ;
   art2.start() ;
   art3.start() ;
   art4.start() ;
   art5.start() ;

   // start the Jury
   juror.start() ;

  }// main()

}
// class DrawingContest
