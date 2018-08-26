
public class SemaphoreTest1
 {
   public static void main(String[] args)
   {
    Semaphore signal = new Semaphore() ;

    Process1 proc1 = new Process1(signal);
    Process1 proc2 = new Process1(signal);

    proc1.start() ;
    proc2.start() ;

   }// main()

 }// class SemaphoreTest1

