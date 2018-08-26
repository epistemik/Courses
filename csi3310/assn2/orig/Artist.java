/*
File: Artist.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

class Artist extends Thread
  {
   private static final int MIN_SLEEP = 1 ;
   private static final int SLEEP_TIME = 8 ;
   private int numColors, first ;
   private Pencils crayons ;
   private Paper papers ;
   private Drawings draw ;
   private boolean[] myColors ;
   private String myName ;

   Artist(Pencils c, Paper p, Drawings d, String name) // constructor
     {
      crayons = c ;
      numColors = c.numColors() ;
      myColors = new boolean[numColors] ;
      papers = p ;
      draw = d ;
      myName = name ;
     }

   boolean allColors()
     {
      for (int i=0; i < numColors; i++)
        if (!myColors[i]) return false ;
      return true ;
     }

   void draw()
     {
      try
        {
         System.out.println(myName + " has made a drawing.") ; // make a drawing

         crayons.release() ;   // release the pencils

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
            first = (int)(Math.random() * numColors) ;
            myColors[first] = crayons.get(first) ;
            for (int i = 1; i < numColors; i++)
               myColors[(first+i) % numColors] = crayons.get((first+i) % numColors) ;

            // make a drawing
            if ( allColors() ) draw();
            else System.err.println("Whoops - missing a pencil!") ;
           }

         // catch any exceptions
         catch (Exception e) { System.err.println("Artist.run()Error: " + e) ; }

        }// endwhile

     }// run()

  } // class Artist

