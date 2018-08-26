
class Thread03
 {
  static public void main(String[] args)
   {
    // Instantiate two new thread objects with names of
    // different lengths which helps when viewing the output.
    Thread threadA = new Thread(new MyThread03(), "thrdA");
    Thread threadB = new Thread(new MyThread03(), "threadB");

    //Start them running
    threadA.start();
    threadB.start();

    try {/* delay for 5 seconds here - but no effect on output.
            - see Thread03a.java which has the same output but no delay. */
         Thread.currentThread().sleep(5000);
        }
    catch (InterruptedException e) {}

   }// main()

 }//end class Thread03

