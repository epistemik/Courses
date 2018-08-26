
class Consumer extends Thread
  {
   byte dataFromQueue ; //used to store the data read from the queue
   QueueManager myMan ;

   Consumer(QueueManager q) //constructor
     { myMan = q ; }

   public void run()
     {
      while (true) //Loop until ^c
        {
         //Invoke the synchronized method to get a byte from the queue
         dataFromQueue = myMan.getByteFromQueue();

         //delay a random amount of time
         try { sleep( (int)(Math.random()*100) ) ; }
         catch (InterruptedException ie) { System.err.println("Error: " + ie) ; }
        }
     }// run()

  }// class Consumer

