
class Sync01
 {
  //Instantiate a class object named QueueManager which
  // will manage the producer/consumer model.
  static QueueManager queueMan ;

  public static void main(String[] args)
   {
    int val ;

    // check for parameter val = size of Queue
    if ( args.length > 0 ) val = Integer.parseInt(args[0]) ;
    else val = 5 ;

    // instantiate the QueueManager
    queueMan = new QueueManager(val) ;

    //instantiate and start two threads
    Thread producer = new Producer(queueMan);
    Thread consumer = new Consumer(queueMan);
    producer.start();
    consumer.start();

   }// main()

 }// class Sync01

