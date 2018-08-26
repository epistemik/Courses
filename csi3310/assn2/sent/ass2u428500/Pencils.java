/*
File: Pencils.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

class Pencils
  {
   private int maxColors ;     // number of colored pencils
   private boolean[] myColors ;  /* array variable to store the pencils
                                    - a value of true in any array element
                                    indicates that this color has been obtained. */

   Pencils(int numColors) // constructor supplies the number of different colors
     {
      // initialize the variables
      myColors = new boolean[numColors] ;
      maxColors = numColors ;
     }

   // accessor for pencil color
   boolean getColor(int index)
     { return myColors[index] ; }

   // mutator for pencil color
   void setColor(int index)
     { myColors[index] = true ; }

   // test if the parameter color is the ONLY color this Pencils is missing
   boolean onlyAbsentColor(int color)
     {
      // return false if this color is present
      if (myColors[color]) return false ;
      // return true if any of the other colors are absent
      for (int i = (color+1) % maxColors; i != color; i = (i+1) % maxColors)
         if (!myColors[i]) return false ;
      return true ;
     }

   // hand back any acquired pencils
   void reset()
     {
      for (int i=0; i < maxColors; i++)
         myColors[i] = false ;
     }

  }// class Pencils

