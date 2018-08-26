/*
File: ColorSemaphore.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

public class ColorSemaphore
  {
   private static final int NUM_COLORS = 4 ;
   private static final int RED = 0 ;
   private static final int GREEN = 1 ;
   private static final int YELLOW = 2 ;
   private static final int BLUE = 3 ;
   //private
   public int redCount, greenCount, yellowCount, blueCount ;

   ColorSemaphore(int numPencils) // constructor provides quantity of each colored pencil
     { redCount = greenCount = yellowCount = blueCount = numPencils ; }

   synchronized void waitColors(Pencils artistPencils)
    {
     while (!artistPencils.allColors())
      {
      // check if need a red pencil
      if (!artistPencils.getColor(RED))
        {
         if(artistPencils.onlyAbsentColor(RED))// if red is the only pencil needed
           {
            while (redCount <= 0) // then wait until a red is available
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("ColorSemaphore.waitColors[RED]Error: " + e) ; }
              }
            redCount-- ;
            artistPencils.setColor(RED) ;
            return ;
           }
         if (redCount > 0) // else take a red pencil if one is free
           {
            redCount-- ;
            artistPencils.setColor(RED) ;
           }
        }//end RED

      // or move on and check if need a green pencil
      if (!artistPencils.getColor(GREEN))
        {
         if(artistPencils.onlyAbsentColor(GREEN))// if green is the only pencil needed
           {
            while (greenCount <= 0) // then wait for a green to be available
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("ColorSemaphore.waitColors[GREEN]Error: " + e) ; }
              }
            greenCount-- ;
            artistPencils.setColor(GREEN) ;
            return ;
           }
         if (greenCount > 0) // else take a green if one is free
           {
            greenCount-- ;
            artistPencils.setColor(GREEN) ;
           }
        }// end GREEN

      // or move on and get a yellow pencil if it is needed
      if (!artistPencils.getColor(YELLOW))
        {
         if(artistPencils.onlyAbsentColor(YELLOW))// if yellow is the only pencil needed
           {
            while (yellowCount <= 0)// then wait until one is free
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("ColorSemaphore.waitColors[YELLOW]Error: " + e) ; }
              }
            yellowCount-- ;
            artistPencils.setColor(YELLOW) ;
            return ;
           }
         if (yellowCount > 0) // else get a yellow pencil if one is free now
           {
            yellowCount-- ;
            artistPencils.setColor(YELLOW) ;
           }
        }//end YELLOW

      // or finish by trying to get a blue pencil if this color is needed
      if (!artistPencils.getColor(BLUE))
        {
         if(artistPencils.onlyAbsentColor(BLUE))// if blue is the only missing color
           {
            while (blueCount <= 0)// then wait until a blue pencil is available
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("ColorSemaphore.waitColors[BLUE]Error: " + e) ; }
              }
            blueCount-- ;
            artistPencils.setColor(BLUE) ;
            return ;
           }
         if (blueCount > 0) // else take a blue pencil if one is free
           {
            blueCount-- ;
            artistPencils.setColor(BLUE) ;
           }
        }//end BLUE

      }//end while

     // then return from the Semaphore
     return ;

    }//waitColors()


   synchronized void signalColors(Pencils usedPencils)
     {
      // increment all the Semaphore counts
      redCount++ ;
      greenCount++ ;
      yellowCount++ ;
      blueCount++ ;

      // release all the pencils and notify any waiting artists
      usedPencils.reset() ;
      notifyAll() ;
     }

   // give the number of colors in this Semaphore
   int numColors()
     { return NUM_COLORS ; }

  }// class ColorSemaphore

