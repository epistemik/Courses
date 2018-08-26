/*
File: Drawings.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

public class Drawings
  {
   private int index, capacity ;
   private String[] submissions ; // array of integers

   Drawings(int capacity) // constructor
     {
      this.capacity = capacity ;
      submissions = new String[capacity] ;
      index = 0 ;
     }

   synchronized int submit(String artistName)
     {
      submissions[index] = artistName ;
      System.out.println(artistName + " has handed drawing #" + index) ;
      index++ ;
      if (index >= capacity)
        notify() ;
      return index-1 ;
     }

   synchronized void full()
     {
      if (index < capacity)
        {
         try { wait() ; }
         catch (Exception e) { System.err.println("Drawings.full()Error: " + e) ; }
        }
     }//full()

   String choose(int select)
     { return submissions[select] ; }


  }// class Drawings
