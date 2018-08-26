
class Thread03a
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

   }// main()

 }//end class Thread03

