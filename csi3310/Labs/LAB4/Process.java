
public class Process extends Thread
 {
  Semaphore mySemaphore ;

  Process(Semaphore s) // constructor
    { mySemaphore = s ; }

  public void run()
    {
     if ( mySemaphore.take() )
       {
        System.out.println("Semaphore is free - printing numbers.") ;
        for (int i =1; i <= 20; i++)
          {
           System.out.println("Number is " + i) ;
           try { this.sleep(200) ; }
           catch (Exception e) { System.err.println("Error: " + e) ; }
          }
        mySemaphore.release() ;
       }
     else
       {
        System.out.println("Semaphore is NOT free - going to sleep.") ;
        try { this.sleep(100) ; }
        catch (Exception e) { System.err.println("Error: " + e) ; }
       }
    }// run()

 }// class Process
