
class Producer extends Thread
 {
  byte byteToStore ; //used to store data to be enqueued
  QueueManager myMan ;

  Producer(QueueManager q) //constructor
    { myMan = q ; }

  public void run()
    {
     while (true) //Loop until ^c
       {
        //get a data byte
        byteToStore = (byte)(Math.random()*128) ;

        //Invoke the synchronized method to put the byte in the queue
        myMan.putByteInQueue(byteToStore);

        //delay a random period of time
        try { sleep( (int)(Math.random()*75) ) ; }
        catch (InterruptedException ie) { System.err.println("Error: " + ie) ; }
       }
    }// run()

 }// class Producer
