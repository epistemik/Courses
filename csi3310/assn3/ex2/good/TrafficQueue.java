/*
File: TrafficQueue.java
Mark Sattolo  428500
CSI 3310  Assn#3 exercise 1 */

class TrafficQueue
  {
   private boolean direction, occupied ;

   TrafficQueue(boolean dir)
     {
      direction = dir ;
      occupied = false ;
     }

   synchronized void cWait()
     {
      occupied = true ;
      try { wait() ; }
      catch (Exception e) { System.err.println("TrafficQueue.cWait()Error: " + e) ; }
     }

   synchronized void cSignal()
     {
      notifyAll() ;
      occupied = false ;
     }

   boolean getDirection()
     { return direction ; }

   synchronized boolean occupied()
     { return occupied ; }

  }// class TrafficQueue

