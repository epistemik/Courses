/*
File: Artist.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

class Artist extends Thread
{
 // constants for the sleep() intervals
 private static final int MIN_SLEEP = 1, SLEEP_TIME = 8 ;
 // the object variables an artist needs
 private ColorSemaphore theSemaphore ;
 private Pencils myPencils ;
 private Paper papers ;
 private Drawings draw ;
 // the number of color pencils required
 private int numColors ;

 Artist( ColorSemaphore c, Paper p, Drawings d, String name ) // constructor
  {
   // initialize all the Artist variables
   super( name ) ;
   theSemaphore = c ;
   numColors = c.numColors() ;
   myPencils = new Pencils( numColors ) ;
   papers = p ;
   draw = d ;
  }

 // test if the artist has all the colored pencils needed
 boolean allColors()
  {
   for( int i=0; i < numColors; i++ )
     if( !myPencils.getColor(i) )
       return false ;

   return true ;
  }

 public void run()
  {
   while( papers.take() )  // continue while there is paper
    {
     try
        {
         // sleep 1-8 ms while getting a sheet of paper
         sleep( MIN_SLEEP + (int)(Math.random() * SLEEP_TIME) );

         // get four different colored pencils via the semaphore
         while( !allColors() )
          { theSemaphore.waitColors( myPencils ) ; }

         // make a drawing
         if( allColors() )
           drawPicture() ;
         else
             System.err.println( "Whoops - missing pencil #" + missingColor() );
        }
     catch( Exception e )
         { System.err.println( "Artist.run() Error: " + e ) ; }

    }// while( papers.take() )

  }
 // run()

 void drawPicture()
  {
   try
      {
       // print message for making a drawing
       System.out.println( this.getName() + " has made a drawing." );

       // Semaphore releases the pencils
       theSemaphore.signalColors( myPencils ) ;

       // sleep 1-8 ms while submitting a drawing
       sleep( MIN_SLEEP + (int)( Math.random() * SLEEP_TIME ) );
       draw.submit( this.getName() );
      }
   catch( Exception e )
       { System.err.println( "Artist.drawPicture() Error: " + e ) ; }

  }
 // drawPicture()

 // determine if the artist is missing a colored pencil
 int missingColor()
  {
   for( int i=0; i < numColors; i++ )
     if( !myPencils.getColor(i) )
       return i ;

   return -1 ;
  }

}
// class Artist
