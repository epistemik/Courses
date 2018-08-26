/*
File: Paper.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

class Paper
  {
   //private
   public int capacity, index ;

   Paper(int numSheets) // constructor
     {
      capacity = numSheets ;
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
     }//take()

   synchronized void empty()
     {
      if (index < capacity)
        {
         try { wait() ; }
         catch (Exception e) { System.err.println("Paper.empty()Error: " + e) ; }
        }
     }//empty()

  }// class Paper
