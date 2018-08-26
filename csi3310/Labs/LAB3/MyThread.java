
public class MyThread extends Thread
 {
  MyThread(String name, int val) // constructor
    {
     setName(name) ;
     setPriority(val) ;
    }

  public void run()
    {
     for ( int i = 0; i < 120; i++ )
         {
          System.out.println(getName() + " <" + getPriority() + "> : loop #" + i) ;
         }
    }// run()

 }// class MyThread
