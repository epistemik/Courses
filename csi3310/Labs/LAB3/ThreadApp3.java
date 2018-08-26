
public class ThreadApp3
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
         p1 = Thread.MIN_PRIORITY ;
         p2 = Thread.MAX_PRIORITY ;
        }

    MyThread3 thread1 = new MyThread3("Arnold", p1) ;
    MyThread3 thread2 = new MyThread3("Wolfgang", thread1, p2) ;

    thread1.start() ;
    //System.out.println("Arnold started") ;
    thread2.start() ;
    //System.out.println("Wolfgang started") ;

    for (int i = 0; i < 121; i++)
        {
         System.out.println(Thread.currentThread().toString() + " : mainloop #" + i) ;
        }

   }// main()

 }// class ThreadApp3

