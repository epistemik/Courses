/*
File: Paper.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

public class Paper
  {
   private int capacity, index ;
   private int[] papers ; // array of integers

   Paper(int capacity) // constructor
     {
      this.capacity = capacity ;
      papers = new int[capacity] ;
      index = 0 ;
     }

   synchronized boolean take()
     {
      if (index < capacity)
        {
         index++ ;
         return true ;
        }
      notify() ;
      return false ;
     }

   synchronized void empty()
     {
      if (index < capacity)
        {
         try { wait() ; }
         catch (Exception e) { System.err.println("Paper.empty()Error: " + e) ; }
        }
     }

  }// class Paper
