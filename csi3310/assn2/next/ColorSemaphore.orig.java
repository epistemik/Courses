/*
File: ColorSemaphore.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

public class ColorSemaphore
  {
   private static final int NUM_COLORS = 4 ;
   private int maxPencils ;
   private int red, green, yellow, blue ;

   ColorSemaphore(int numPencils) // constructor
     {
      red = green = yellow = blue = 0 ;
      maxPencils = numPencils ;
     }

   synchronized void getColors(Pencils artistPencils)
     {
      if (!artistPencils.getColor(0))
        {
         if(artistPencils.getColor(1) && artistPencils.getColor(2) && artistPencils.getColor(3))
           {
            while (red >= maxPencils)
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("ColorSemaphore.getColors(red)Error: " + e) ; }
              }
            red++ ;
            artistPencils.setColor(0) ;
            return ;
           }
         if (red < maxPencils)
           {
            red++ ;
            artistPencils.setColor(0) ;
           }
        }//endif color(0)

      if (!artistPencils.getColor(1))
        {
         if(artistPencils.getColor(0) && artistPencils.getColor(2) && artistPencils.getColor(3))
           {
            while (green >= maxPencils)
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("ColorSemaphore.getColors(green)Error: " + e) ; }
              }
            green++ ;
            artistPencils.setColor(1) ;
            return ;
           }
         if (green < maxPencils)
           {
            green++ ;
            artistPencils.setColor(1) ;
           }
        }//endif color(1)

      if (!artistPencils.getColor(2))
        {
         if(artistPencils.getColor(0) && artistPencils.getColor(1) && artistPencils.getColor(3))
           {
            while (yellow >= maxPencils)
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("ColorSemaphore.getColors(yellow)Error: " + e) ; }
              }
            yellow++ ;
            artistPencils.setColor(2) ;
            return ;
           }
         if (yellow < maxPencils)
           {
            yellow++ ;
            artistPencils.setColor(2) ;
           }
        }//endif color(2)

      if (!artistPencils.getColor(3))
        {
         if(artistPencils.getColor(0) && artistPencils.getColor(1) && artistPencils.getColor(2))
           {
            while (blue >= maxPencils)
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("ColorSemaphore.getColors(blue)Error: " + e) ; }
              }
            blue++ ;
            artistPencils.setColor(3) ;
            return ;
           }
         if (blue < maxPencils)
           {
            blue++ ;
            artistPencils.setColor(3) ;
           }
        }//endif color(3)

      return ;
     }//getColors()

 /*  synchronized void getOneColor(Pencils testPencil, int color)
     {
      switch(color)
        {
         case 0: { red++ ;
                   testPencil.fillColor(0) ;
                   return ; }
         case 1: { green++ ;
                   testPencil.fillColor(1) ;
                   return ; }
         case 2: { red++ ;
                   testPencil.fillColor(2) ;
                   return ; }
         case 3: { green++ ;
                   testPencil.fillColor(3) ;
                   return ; }
         default:
                 System.err.println("Invalid color choice.") ;
        }
     }    */

   synchronized void release(Pencils usedPencils)
     {
      red-- ;
      green-- ;
      yellow-- ;
      blue-- ;
      usedPencils.reset() ;
      notifyAll() ;
     }

   int numColors()
     { return NUM_COLORS ; }

  }// class ColorSemaphore

