
public class Process1 extends Thread
 {
  Semaphore mySemaphore ;

  Process1(Semaphore s) // constructor
    { mySemaphore = s ; }

  public void run()
    {
     while ( !mySemaphore.take() )
       {
        System.out.println("Semaphore is NOT free - going to sleep.") ;
        try { this.sleep(100) ; }
        catch (Exception e) { System.err.println("Error: " + e) ; }
       }
     System.out.println("Semaphore is free - printing numbers.") ;
     for (int i =1; i <= 20; i++)
       {
        System.out.println("Number is " + i) ;
        try { this.sleep(200) ; }
        catch (Exception e) { System.err.println("Error: " + e) ; }
       }
     mySemaphore.release() ;
    }// run()

 }// class Process1
