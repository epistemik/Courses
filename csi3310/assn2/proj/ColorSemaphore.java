/*
File: ColorSemaphore.java
Mark Sattolo  428500
CSI 3310  Assn#2  */


public class ColorSemaphore
{
 /* constants for the total number of colors
    and the position in the array of each individual color  */
 private static final int
 RED = 0, GREEN = 1, YELLOW = 2, BLUE = 3, NUM_COLORS = 4 ;

 // an integer array to hold the count for each color
 private int[] count ;

 // constructor provides the quantity of each colored pencil
 ColorSemaphore( int numPencils )
  {
   // initialize the count variable for all the colors
   count = new int[ NUM_COLORS ] ;
   for( int i=0; i < NUM_COLORS; i++ )
     count[i] = numPencils ;
  }

 // wait() method of the Semaphore
 synchronized void waitColors( Pencils artistPencils )
  {
   // check if need a red pencil
   if( !artistPencils.getColor(RED) )
    {
     if( artistPencils.onlyAbsentColor(RED) )// if red is the only pencil needed
      {
       setColor( artistPencils, RED ); // wait for red then return
       return ;
      }
     if( count[RED] > 0 ) // else take a red pencil if one is free
      {
       count[RED]-- ;
       artistPencils.setColor( RED );
      }
    }// RED

   // or move on and check if need a green pencil
   if( !artistPencils.getColor(GREEN) )
    {
     if( artistPencils.onlyAbsentColor(GREEN) )// if green is the only pencil needed
      {
       setColor( artistPencils, GREEN ); // wait for green then return
       return ;
      }
     if( count[GREEN] > 0 ) // else take a green pencil if one is free
      {
       count[GREEN]-- ;
       artistPencils.setColor( GREEN );
      }
    }// GREEN

   // or move on and get a yellow pencil if it is needed
   if( !artistPencils.getColor(YELLOW) )
    {
     if( artistPencils.onlyAbsentColor(YELLOW) )// if yellow is the only pencil needed
      {
       setColor( artistPencils, YELLOW ); // wait for yellow then return
       return ;
      }
     if( count[YELLOW] > 0 ) // else take a yellow pencil if one is free
      {
       count[YELLOW]-- ;
       artistPencils.setColor( YELLOW );
      }
    }// YELLOW

   // or finish by trying to get a blue pencil if this color is needed
   if( !artistPencils.getColor(BLUE) )
    {
     if( artistPencils.onlyAbsentColor(BLUE) )// if blue is the only missing color
      {
       setColor( artistPencils, BLUE ); // wait for blue then return
       return ;
      }
     if( count[BLUE] > 0 ) // else take a blue pencil if one is free
      {
       count[BLUE]-- ;
       artistPencils.setColor( BLUE );
      }
    }// BLUE

   // then return from the Semaphore
   return ;
  }
 // waitColors()


 // signal() method of the Semaphore
 synchronized void signalColors( Pencils usedPencils )
  {
   // increment all the Semaphore counts
   for( int i=0; i < NUM_COLORS; i++ )
     count[i]++ ;

   // release all the pencils and notify any waiting artists
   usedPencils.reset() ;
   notifyAll() ;
  }
 // signalColors()


 // assign the required pencil color
 private void setColor( Pencils p, int color )
  {
   while( count[color] <= 0 ) // wait until the needed color is available
    {
     try { wait() ; }

     catch( Exception e )
         { System.err.println( "ColorSemaphore.setColor() Error: " + e ) ; }
    }
   // then decrement the count and set the pencil color
   count[color]-- ;
   p.setColor( color );
   return ;
  }
 // setColor()


 // give the number of colors in this Semaphore
 int numColors()
  { return NUM_COLORS ; }


}
// class ColorSemaphore
