
public class Semafore
  {
   private int block ;

   Semafore() // constructor
     { block = 0 ; }

   synchronized void take(int maxOthers, String threadName)
     {
      while (block > maxOthers)
        {
         try {
              System.out.println(threadName + " wants to run.") ;
              wait() ;
             }
         catch (Exception e) { System.err.println("take()Error: " + e) ; }
        }
      block++ ;
     }

   synchronized void check(int maxOthers, String threadName)
     {
      while (block > maxOthers)
        {
         try {
              System.out.println(threadName + " wants to run.") ;
              wait() ;
             }
         catch (Exception e) { System.err.println("Error: " + e) ; }
        }
     }

   int count()
     { return block ; }

   synchronized void release(String threadName)
     {
      block-- ;
      try { notifyAll() ; }
      catch (Exception e) { System.err.println("Error: " + e) ; }
     }

  }// class Semafore
