
public class SemaphoreTest
 {
   public static void main(String[] args)
   {
    Semaphore signal = new Semaphore() ;

    Process proc1 = new Process(signal);
    Process proc2 = new Process(signal);

    proc1.start() ;
    proc2.start() ;

   }// main()

 }// class SemaphoreTest

