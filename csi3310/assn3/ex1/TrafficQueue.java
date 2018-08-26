/*
File: TrafficQueue.java
Mark Sattolo  428500
CSI 3310  Assn#3 exercise 1 */

class TrafficQueue
  {
   private boolean direction, occupied ;
   int count ;
   String name ;

   TrafficQueue(boolean dir)
     {
      direction = dir ;
      occupied = false ;
      count = 0 ;
      name = dir ? "Northbound" : "Southbound" ;
     }

   synchronized void cWait()
     {
      count++ ;
      System.out.println("\t >> " + name + " queue has " + count + " elements.") ;
      occupied = true ;
      try { wait() ; }
      catch (Exception e) { System.err.println("TrafficQueue.cWait()Error: " + e) ; }
     }

   synchronized void cSignal()
     {
      notifyAll() ;
      occupied = false ;
      count = 0 ;
     }

   boolean getDirection()
     { return direction ; }

   synchronized boolean occupied()
     { return occupied ; }

  }// class TrafficQueue

