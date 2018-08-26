/*
File: TrafficQueue.java
Mark Sattolo  428500
CSI 3310  Assn#3 exercise 1 */

class TrafficQueue
  {
   private boolean direction,  // direction of this queue
                   occupied ;  // if this queue is occupied or not

   TrafficQueue(boolean dir) // constructor supplies the direction
     {
      direction = dir ;
      occupied = false ;     // occupied starts as false
     }

   synchronized void cWait()
     {
      // queue is occupied
      occupied = true ;
      // calling thread will go into a queue
      try { wait() ; }
      catch (Exception e) { System.err.println("TrafficQueue.cWait()Error: " + e) ; }
     }

   synchronized void cSignal()
     {
      // threads in the queue are released
      notifyAll() ;
      // queue is now unoccupied
      occupied = false ;
     }

   boolean getDirection()  // inform the direction of this queue
     { return direction ; }

   synchronized boolean occupied() // inform the state of this queue
     { return occupied ; }

  }// class TrafficQueue

