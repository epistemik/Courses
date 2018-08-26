
public class ThreadApp2
 {
   public static void main(String[] args)
   {
    Point p1 = new Point(1,1) ;
    Point p2 = new Point(2,2) ;

    MyThread thread1 = new MyThread("Thomas", p1);
    MyThread thread2 = new MyThread("Marie-Laure", p2);

    thread1.start() ;
    thread2.start() ;

   }// main()

 }// class ThreadApp2

