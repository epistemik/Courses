
public class ThreadApp1
 {
  public static void main(String[] args)
   {
    MyThread1 thread1 = new MyThread1() ;  // MyThread1's are started by the
    MyThread1 thread2 = new MyThread1() ;  // constructor

    for (int i = 0; i < 120; i++)
        {
         System.out.println("Main " + "<" + Thread.currentThread().getPriority()
          + "> : loop #" + i) ;
        }

   }// main()

 }// class ThreadApp1

