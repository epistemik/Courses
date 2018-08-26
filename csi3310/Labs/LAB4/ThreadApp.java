
public class ThreadApp
 {
   public static void main(String[] args)
   {
    Point p = new Point() ;

    MyThread thread1 = new MyThread("Thomas", p);
    MyThread thread2 = new MyThread("Marie-Laure", p);

    thread1.start() ;
    thread2.start() ;

   }// main()

 }// class ThreadApp

