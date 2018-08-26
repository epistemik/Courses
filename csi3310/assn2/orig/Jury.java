/*
File: Jury.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

class Jury extends Thread
  {
   Paper entries ;         // the blank papers
   Drawings contest ;      // the contest submissions
   private int capacity, choice ;  // number of submissions and winning drawing

   Jury(Paper p, Drawings d, int sheets) // constructor supplies Paper & Drawings
     {
      entries = p ;
      contest = d ;
      capacity = sheets ;
     }

   public void run()
     {
      // wait until the paper is gone
      entries.empty() ;
      // make sure all the submissions are in
      contest.full() ;
      // choose a winner
      choice = (int)((capacity+1)*Math.random()) ;
      System.out.println("\n And the winning artist is... " + contest.choose(choice) + "!\n") ;
     }

  } // class Jury

