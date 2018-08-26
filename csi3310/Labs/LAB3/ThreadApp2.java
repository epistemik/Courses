
public class ThreadApp2
 {
  public static void main(String[] args)
   {
    MyThread2 thread1 = new MyThread2("fred") ;
    MyThread2 thread2 = new MyThread2("barney") ;

    // use the start() method of MyThread2 to start the threads
    thread1.start() ;
    thread2.start() ;

    for (int i = 0; i < 120; i++)
        {
         System.out.println("Main " + "<" + Thread.currentThread().getPriority()
          + "> : loop #" + i) ;
        }

   }// main()

 }// class ThreadApp2

