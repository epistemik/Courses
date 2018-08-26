/*
File: TrafficQueue.java
Mark Sattolo  428500
CSI 3310  Assn#3 exercise 1 */

class TrafficQueue
  {
   synchronized void cWait()
     {
      try { wait() ; }
      catch (Exception e) { System.err.println("TrafficQueue.cWait()Error: " + e) ; }
     }

   synchronized void cSignal()
     {
      notifyAll() ;
     }

  }// class TrafficQueue

