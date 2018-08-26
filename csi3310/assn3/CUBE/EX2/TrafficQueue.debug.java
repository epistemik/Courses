/*
File: TrafficQueue.java
Mark Sattolo  428500
CSI 3310  Assn#3 exercise 2 */

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
      name = dir ? "North" : "South" ;
     }

   synchronized void cWait(int nb)
     {
      count++ ;
      System.out.println("\t >> " + name + "bound car " + nb + " is in the queue.") ;
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

