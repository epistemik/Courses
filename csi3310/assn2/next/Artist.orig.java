/*
File: Artist.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

class Artist extends Thread
  {
   private static final int MIN_SLEEP = 1 ;
   private static final int SLEEP_TIME = 8 ;
   private int numColors ;
   private ColorSemaphore theColors ;
   private Pencils myPencils ;
   private Paper papers ;
   private Drawings draw ;
   private String myName ;

   Artist(ColorSemaphore c, Paper p, Drawings d, String name) // constructor
     {
      theColors = c ;
      numColors = c.numColors() ;
      myPencils = new Pencils(numColors) ;
      papers = p ;
      draw = d ;
      myName = name ;
     }

   boolean allColors()
     {
      for (int i=0; i < numColors; i++)
         if (!myPencils.getColor(i)) return false ;
      return true ;
     }

   int missingColor()
     {
      for (int i=0; i < numColors; i++)
         if (!myPencils.getColor(i)) return i ;
      return -1 ;
     }

   void draw()
     {
      try
        {
         System.out.println(myName + " has made a drawing.") ; // make a drawing

         theColors.release(myPencils) ;   // release the pencils

         // sleep 1-8 ms while submitting a drawing
         sleep( MIN_SLEEP + (int)(Math.random() * SLEEP_TIME) ) ;
         draw.submit(myName) ;  // submit the drawing
        }
      // catch any exceptions
      catch (Exception e) { System.err.println("Artist.draw()Error: " + e) ; }
     }

    public void run()
     {
      while (papers.take())  // continue while there is paper
        {
         try
           {
            // sleep 1-8 ms while getting a sheet of paper
            sleep( MIN_SLEEP + (int)(Math.random() * SLEEP_TIME) ) ;

            // get four different pencils
            while (!allColors())
               { theColors.getColors(myPencils) ; }

            // make a drawing
            if (allColors()) draw();
            else System.err.println("Whoops - missing pencil #" + missingColor()) ;
           }

         // catch any exceptions
         catch (Exception e) { System.err.println("Artist.run()Error: " + e) ; }

        }// endwhile

     }// run()

  } // class Artist

