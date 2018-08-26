/*
File: Pencils.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

class Pencils
  {
   private int maxColors ;
   private boolean[] myColors ;

   Pencils(int numColors) // constructor
     {
      myColors = new boolean[numColors] ;
      maxColors = numColors ;
     }

   boolean getColor(int index)
     { return myColors[index] ; }

   void setColor(int index)
     { myColors[index] = true ; }

   boolean onlyAbsentColor(int color)
     { //System.err.println("color: " + color ) ;
      if (myColors[color]) return false ;
      for (int i = (color+1) % maxColors; i != color; i = (i+1) % maxColors)
      { //System.err.println("color: " + color + " / i: " + i) ;
         if (!myColors[i]) return false ;                    }
      return true ;
     }

   void reset()
     {
      for (int i=0; i < maxColors; i++)
         myColors[i] = false ;
     }

  }// class Pencils

