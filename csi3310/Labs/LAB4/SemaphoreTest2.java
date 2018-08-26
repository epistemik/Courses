
public class SemaphoreTest2
 {
   public static void main(String[] args)
   {
    Semaphore2 signal = new Semaphore2() ;

    Process2 proc1 = new Process2(signal);
    Process2 proc2 = new Process2(signal);

    proc1.start() ;
    proc2.start() ;

   }// main()

 }// class SemaphoreTest2

