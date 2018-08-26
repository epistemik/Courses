
public class MyThread2 implements Runnable
 {
  Thread t2 ;  // Thread variable

  MyThread2(String name) // constructor
    {
     t2 = new Thread(this) ;
     t2.setName(name) ;
    }

  public void start()  // define a start() method for MyThread2
    {                  // (interface Runnable does not define a start() method)
     t2.start() ;
    }

  public void run()
    {
     for ( int i = 0; i < 120; i++ )
         {
          System.out.println(Thread.currentThread().getName() + " <"
          + Thread.currentThread().getPriority() + "> : loop #" + i) ;
         }
    }// run()

 }// class MyThread2
