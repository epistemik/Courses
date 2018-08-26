/*
File: Pencils.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

public class Pencils
  {
   private static final int NUM_COLORS = 4 ;
   private static int maxPencils ;
   private int red, green, yellow, blue ;

   Pencils(int num) // constructor
     {
      red = green = yellow = blue = 0 ;
      maxPencils = num ;
     }

   synchronized boolean get(int color)
     {
      switch(color)
        {
         case 0:
           {
            while (red >= maxPencils)
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("Pencils.get(red)Error: " + e) ; }
              }
            red++ ;
            return true ;
           }
         case 1:
           {
            while (green >= maxPencils)
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("Pencils.get(green)Error: " + e) ; }
              }
            green++ ;
            return true ;
           }
         case 2:
           {
            while (yellow >= maxPencils)
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("Pencils.get(yellow)Error: " + e) ; }
              }
            yellow++ ;
            return true ;
           }
         case 3:
           {
            while (blue >= maxPencils)
              {
               try { wait() ; }
               catch (Exception e) { System.err.println("Pencils.get(blue)Error: " + e) ; }
              }
            blue++ ;
            return true ;
           }
         default:
           {
            System.err.println("Invalid number for pencil color! \n") ;
            return false ;
           }
        }//switch()
     }//get()

   synchronized void release()
     {
      red-- ;
      green-- ;
      yellow-- ;
      blue-- ;
      notifyAll() ;
     }

   int numColors()
     { return NUM_COLORS ; }

  }// class Pencils

