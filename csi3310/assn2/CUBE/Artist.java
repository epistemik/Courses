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

   Artist(ColorSemaphore c, Paper p, Drawings d, String name) // constructor
     {
      super(name) ;
      theColors = c ;
      numColors = c.numColors() ;
      myPencils = new Pencils(numColors) ;
      papers = p ;
      draw = d ;
     }

    public void run()
     {
      while ( papers.take() )  // continue while there is paper
        {
         try
           {
            // sleep 1-8 ms while getting a sheet of paper
            sleep( MIN_SLEEP + (int)(Math.random() * SLEEP_TIME) ) ;

            // get four different colored pencils via the semaphore
            theColors.waitColors(myPencils) ;

            sleep( MIN_SLEEP + (int)(Math.random() * SLEEP_TIME) ) ;

            // make a drawing
            if ( myPencils.allColors() )  drawPicture() ;
            else System.err.println("Whoops - missing pencil #" + missingColor()) ;
           }

         // catch any exceptions
         catch (Exception e) { System.err.println("Artist.run()Error: " + e) ; }

        }// endwhile

     }// run()

   void drawPicture()
     {
      try
        {
         // make a drawing
         System.out.println(this.getName() + " has made a drawing.") ;

         // Semaphore releases the pencils
         theColors.signalColors(myPencils) ;

         // sleep 1-8 ms while submitting a drawing
         sleep( MIN_SLEEP + (int)(Math.random() * SLEEP_TIME) ) ;
         draw.submit(this.getName()) ;
        }
      // catch any exceptions
      catch (Exception e) { System.err.println("Artist.draw()Error: " + e) ; }
     }// drawPicture()

   int missingColor()
     {
      for (int i=0; i < numColors; i++)
         if (!myPencils.getColor(i)) return i ;
      return -1 ;
     }

  } // class Artist

