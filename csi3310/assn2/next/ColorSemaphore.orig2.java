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
   private int maxPencils ;
   private int redTaken, greenTaken, yellowTaken, blueTaken ;

   ColorSemaphore(int numPencils) // constructor
     {
      redTaken = greenTaken = yellowTaken = blueTaken = 0 ;
      maxPencils = numPencils ;
     }

   synchronized void waitColors(Pencils artistPencils)
     {
      // check if need a red pencil
      if (!artistPencils.getColor(RED))
        {
         if(artistPencils.onlyAbsentColor(RED))// if red is the only pencil needed
           {
            while (redTaken >= maxPencils) // then wait until a red is available
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("ColorSemaphore.waitColors(RED)Error: " + e) ; }
              }
            redTaken++ ;
            artistPencils.setColor(RED) ;
            return ;
           }
         if (redTaken < maxPencils) // else take a red pencil if one is free
           {
            redTaken++ ;
            artistPencils.setColor(RED) ;
           }
        }

      // or move on and check if need a green pencil
      if (!artistPencils.getColor(GREEN))
        {
         if(artistPencils.onlyAbsentColor(GREEN))// if green is the only pencil needed
           {
            while (greenTaken >= maxPencils) // then wait for a green to be available
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("ColorSemaphore.waitColors(GREEN)Error: " + e) ; }
              }
            greenTaken++ ;
            artistPencils.setColor(GREEN) ;
            return ;
           }
         if (greenTaken < maxPencils) // else take a green only if one is free
           {
            greenTaken++ ;
            artistPencils.setColor(GREEN) ;
           }
        }

      // or move on and get a yellow pencil if it is needed
      if (!artistPencils.getColor(YELLOW))
        {
         if(artistPencils.onlyAbsentColor(YELLOW))// if yellow is the only pencil needed
           {
            while (yellowTaken >= maxPencils)// then wait until one is free
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("ColorSemaphore.waitColors(YELLOW)Error: " + e) ; }
              }
            yellowTaken++ ;
            artistPencils.setColor(YELLOW) ;
            return ;
           }
         if (yellowTaken < maxPencils) // else get a yellow only if one is free now
           {
            yellowTaken++ ;
            artistPencils.setColor(YELLOW) ;
           }
        }

      // or finish by trying to get a blue pencil if this color is needed
      if (!artistPencils.getColor(BLUE))
        {
         if(artistPencils.onlyAbsentColor(BLUE))// if blue is the only missing color
           {
            while (blueTaken >= maxPencils)// then wait until a blue pencil is available
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("ColorSemaphore.waitColors(BLUE)Error: " + e) ; }
              }
            blueTaken++ ;
            artistPencils.setColor(BLUE) ;
            return ;
           }
         if (blueTaken < maxPencils) // else take a blue pencil if one is free
           {
            blueTaken++ ;
            artistPencils.setColor(BLUE) ;
           }
        }

      // then return from the Semaphore
      return ;

     }//waitColors()


   synchronized void signalColors(Pencils usedPencils)
     {
      // decrement all the Semaphore flags
      redTaken-- ;
      greenTaken-- ;
      yellowTaken-- ;
      blueTaken-- ;

      // release all the pencils and notify any waiting artists
      usedPencils.reset() ;
      notifyAll() ;
     }

   // inform of the number of colors in this Semaphore
   int numColors()
     { return NUM_COLORS ; }

  }// class ColorSemaphore

