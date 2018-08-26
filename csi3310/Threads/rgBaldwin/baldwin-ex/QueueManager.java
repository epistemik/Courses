
// This class implements the Producer/Consumer model
// by managing a queue as a shared resource.
class QueueManager
 {
  Queue myQueue ;
  int queueSize ;

  QueueManager(int val) //constructor
    {
     queueSize = val ;
     myQueue = new Queue(val) ;  //instantiate a queue object
    }

  synchronized void putByteInQueue(byte incomingByte)
    {
     // This synchronized method places a byte in the queue.
     // If the queue is full, wait().
     // If still full when wait() terminates, wait again.
     // Called by the producer thread to put a byte in the queue.
     try { while ( myQueue.isFull() )
            {
             System.out.println("QUEUE FULL - WAITING" ) ;
             printQueue() ;
             System.out.println(" ") ;
             wait();
            }//end while loop
         }
     catch (InterruptedException ie)
          { System.err.println("InterruptedException: " + ie); }//end catch block

     //put the byte into the queue
     myQueue.enQueue(incomingByte);
     System.out.println("Enqueueing value: " + incomingByte);

     printQueue() ;

     //wake up getByteFromQueue() if it has invoked wait().
     notify();
     System.out.println("Notifying consumer...\n");

    }//putByteInQueue()


  public synchronized byte getByteFromQueue()
    {
     // This synchronized method removes a byte from the queue.
     // If the queue is empty, wait().
     // If still empty when wait() terminates, wait again.
     // Called by consumer thread to get a byte from the queue.
     try { while ( myQueue.isEmpty() )
            {
             System.out.println("QUEUE EMPTY - WAITING" ) ;
             printQueue() ;
             System.out.println(" ") ;
             wait() ;
            }// end while
        }
     catch (InterruptedException ie)
         { System.err.println("InterruptedException: " + ie) ; }

     //get the byte from the queue
     byte data = myQueue.serve() ;
     System.out.println("Getting value: " + data);

     printQueue() ;

     //wake up putByteInQueue() if it has invoked wait().
     notify() ;
     System.out.println("Notifying producer...\n");
     return data ;

    }// getByteFromQueue()


  void printQueue()
    {
     if ( myQueue.isEmpty() )
        System.out.println("QUEUE: []") ;
     else
         {
          int j = 0 ;
          System.out.print("QUEUE: [ ") ;
          for (int i = myQueue.front; j < myQueue.count ; i = (i+1) % queueSize)
            {
             System.out.print(myQueue.look()[i] + " " ) ;
             j++ ;
            }
          System.out.println("] ") ;
         }
    }// printQueue()

 }// class QueueManager

