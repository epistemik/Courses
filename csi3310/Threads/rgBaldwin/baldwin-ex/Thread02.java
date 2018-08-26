
class Thread02
 {
  static public void main(String[] args)
   {
    //Instantiate two new thread objects
    Thread myThreadA = new Thread(new MyThread(),"threadA");
    Thread myThreadB = new Thread(new MyThread(),"threadB");

    //Start them running
    myThreadA.start();
    myThreadB.start();

    try
       {//delay for 5 seconds - but no effect on output
       Thread.currentThread().sleep(5000);
       }
    catch(InterruptedException e){}

    //Display info about the "main" thread
    System.out.println(Thread.currentThread());

   }// main()

 }// class Thread02

