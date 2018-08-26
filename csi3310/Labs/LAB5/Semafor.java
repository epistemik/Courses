
public class Semafor
  {
   private int readers, writers ;

   Semafor() // constructor
     {
      readers = 0 ;
      writers = 0 ;
     }

   synchronized boolean writeTake()
     {
      while (writers > 0 || readers > 0)
        {
         try { wait() ; }
         catch (Exception e) { System.err.println("writeTakeError: " + e) ; }
        }
      writers++ ;
      System.out.println("There are " + readers + " readers and " + writers + " writers.") ;
      return true ;
     }

   synchronized void writeRelease()
     {
      writers-- ;
      System.out.println("There are " + readers + " readers and " + writers + " writers.") ;
      notifyAll() ;
     }


   synchronized boolean readTake()
     {
      while (writers > 0)
        {
         try { wait() ; }
         catch (Exception e) { System.err.println("readTakeError: " + e) ; }
        }
      readers++ ;
      System.out.println("There are " + readers + " readers and " + writers + " writers.") ;
      return true ;
     }

   synchronized void readRelease()
     {
      readers-- ;
      System.out.println("There are " + readers + " readers and " + writers + " writers.") ;
      if (readers == 0)
         notify() ;
     }

  }// class Semafor
