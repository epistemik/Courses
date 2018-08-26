
class Semaphore
  {
   private boolean free ;

   Semaphore() // constructor
     { free = true ; }

   synchronized boolean take()
     {
      if (free)
        {
         free = false ;
         return true ;
        }
      else return false ;
     }// take()

   synchronized void release()
     { free = true ; }

  }// class Semaphore
