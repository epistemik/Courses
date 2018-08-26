/*
File: Jury.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

class Jury extends Thread
  {
   Paper sheets ;          // the blank papers
   Drawings entries ;      // the contest submissions
   private int capacity,   // number of submissions
               choice ;    // winning drawing

   // constructor supplies Paper, Drawings & capacity
   Jury(Paper p, Drawings d, int numSheets) 
     {
      sheets = p ;
      entries = d ;
      capacity = numSheets ;
     }

   public void run()
     {
      // wait until the paper is gone
      sheets.empty() ;
      // make sure all the submissions are in
      entries.full() ;
      // choose a winner
      choice = (int)((capacity+1)*Math.random()) ;
      System.out.println("\n And the winning artist is... " + entries.choose(choice) + "!\n") ;
     }

  } // class Jury

