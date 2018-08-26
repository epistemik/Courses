
public class Semaphore3
  {
   private boolean free ;

   Semaphore3() // constructor
     { free = true ; }

   synchronized boolean take()  // better implementation - as Java has separate
     {                          // synchronized and wait() queues.  notifyAll()
      while (!free)             // cannot now release all waiting threads to
        {                       // take the semaphore.
         try { wait() ; }
         catch (Exception e) { System.err.println("Error: " + e) ; }
        }
      free = false ;
      return true ; 
     }

   synchronized void release()
     {
      free = true ;
      try { notify() ; }
      catch (Exception e) { System.err.println("Error: " + e) ; }
     }

  }// class Semaphore3
