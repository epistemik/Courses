
public class Semafor2
  {
   private int readers, writers ;
   private boolean writeRequest ; // writers can be given priority

   Semafor2() // constructor
     {
      readers = 0 ;
      writers = 0 ;
      writeRequest = false ;
     }

   synchronized void writeTake(String threadName)
     {
      while (writers > 0 || readers > 0)
        {
         try {
              writeRequest = true ;
              System.out.println(threadName + " wants to write.") ;
              wait() ;
             }
         catch (Exception e) { System.err.println("writeTake()Error: " + e) ; }
        }
      writers++ ;
      System.out.println(threadName + " is writing.") ;
      System.out.println("There are " + readers + " readers and " + writers + " writers.\n") ;
      writeRequest = false ;
     }

   synchronized void writeRelease(String threadName)
     {
      writers-- ;
      System.out.println(threadName + " has finished writing.") ;
      System.out.println("There are " + readers + " readers and " + writers + " writers.\n") ;
      notifyAll() ; //notify all readers & writers that the queue is empty
     }


   synchronized void readTake(String threadName)
     {
      while (writers > 0 || writeRequest)  //give priority to writers
        {
         try {
              wait() ;
              System.out.println(threadName + " wants to read.") ;
              }
         catch (Exception e) { System.err.println("readTake()Error: " + e) ; }
        }
      readers++ ;
      System.out.println(threadName + " is reading.") ;
      System.out.println("There are " + readers + " readers and " + writers + " writers.\n") ;
     }

   synchronized void readRelease(String threadName)
     {
      readers-- ;
      System.out.println(threadName + " has finished reading.") ;
      System.out.println("There are " + readers + " readers and " + writers + " writers.\n") ;
      if (readers == 0)
         notify() ; //notify a writer that the queue is empty
     }

  }// class Semafor2
