
class MyThread03 implements Runnable
 {
  public void run()
   {
    for(int count = 0; count < 5; count++)
     {
      System.out.println(Thread.currentThread() + " count is " + count);
      try {//delay a random amount of time
           Thread.currentThread().sleep((int)(Math.random() * 100));
          }
      catch (InterruptedException e) {}
     }//end for-loop

   }//end run()
   
 }//end class MyThread03
