
public class Semaphore2
  {
   private boolean free ;

   Semaphore2() // constructor
     { free = true ; }

   synchronized void take()
     {
      if (free)
        { free = false ; }
      else
        {
         try { wait() ; }
         catch (Exception e) { System.err.println("Error: " + e) ; }
         free = false ;
        }
     }

   synchronized void release()
     {
      free = true ;
      try { notify() ; }
      catch (Exception e) { System.err.println("Error: " + e) ; }
     }

  }// class Semaphore2
