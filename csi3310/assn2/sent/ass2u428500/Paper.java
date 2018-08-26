/*
File: Paper.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

class Paper
  {
   private int capacity,    // total number of papers
               index ;      // index of the current sheet of paper

   Paper(int numSheets) // constructor supplies initial number of sheets of paper
     {
      capacity = numSheets ;
      index = 0 ;
     }

   // give out the sheets of paper
   synchronized boolean take()
     {
      // give out a sheet if any remain
      if (index < capacity)
        {
         index++ ;
         return true ;
        }
      // notify that all the papers have been handed out
      notify() ;
      return false ;
     }

   // test if all the papers have been handed out
   synchronized void empty()
     {
      if (index < capacity)
        {
         // wait until there are no more papers
         try { wait() ; }
         catch (Exception e) { System.err.println("Paper.empty()Error: " + e) ; }
        }
     }

  }// class Paper
