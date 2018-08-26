
public class Chopstick
  {
   private boolean free ;

   Chopstick() // constructor
     { free = true ; }

   synchronized boolean take()
     {
      while (!free)
        {
         try { wait() ; }
         catch (Exception e) { System.err.println("writeTakeError: " + e) ; }
        }
      free = false ;
      System.out.println("Chopstick has been taken.") ;
      return true ;
     }

   synchronized void release()
     {
      free = true ;
      System.out.println("Chopstick is free.") ;
      notify() ;
     }

  }// class Chopstick
