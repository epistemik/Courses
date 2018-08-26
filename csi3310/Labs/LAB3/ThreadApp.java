
public class ThreadApp
 {
   public static void main(String[] args)
   {
    int p1, p2 ;
    if (args.length > 1)
       {
        p1 = Integer.parseInt(args[0]) ;
        p2 = Integer.parseInt(args[1]) ;
       }
    else
        {
         p1 = Thread.MAX_PRIORITY ;
         p2 = Thread.MIN_PRIORITY ;
        }
    MyThread thread1 = new MyThread("Richard", p1);
    MyThread thread2 = new MyThread("Isabel", p2);

    // start the threads
    thread1.start() ;
    thread2.start() ;

    // a loop for the main() thread
    for (int i = 0; i < 120; i++)
        {
         System.out.println(Thread.currentThread().getName()
         + " <" + Thread.currentThread().getPriority() + "> : loop #" + i) ;
        }

   }// main()

 }// class ThreadApp

