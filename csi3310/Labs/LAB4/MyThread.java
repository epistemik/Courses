
public class MyThread extends Thread
 {
  Point myPoint ;

  MyThread(String name, Point p) // constructor
    {
     setName(name) ;
     myPoint = p ;
    }

  public void run()
    {
     myPoint.setX(myPoint.getY()) ;
    }// run()

 }// class MyThread
