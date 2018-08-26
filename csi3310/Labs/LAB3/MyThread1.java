
public class MyThread1 implements Runnable
 {
  MyThread1() // constructor starts a Thread based on MyThread1
    {
     new Thread(this).start() ;
    }

  public void run()
    {
     for ( int i = 0; i < 120; i++ )
         {
          System.out.println(Thread.currentThread().getName() + " <"
          + Thread.currentThread().getPriority() + "> : loop #" + i) ;
         }
    }// run()

 }// class MyThread1
