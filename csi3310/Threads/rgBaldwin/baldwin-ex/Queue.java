
class Queue
  {
    //variable defining maximum queue size
    int maxQueue ;
    byte[] queue ;
    int front, rear, count ;

    Queue(int maxQ) //constructor
     {
      maxQueue = maxQ ;
      queue = new byte[maxQueue] ;
      front = rear = count = 0 ;
     }

    void enQueue(byte item)
     {
      queue[rear] = item ;
      rear = next(rear) ;
      count++ ;
     }// enQueue()

    // pass the queue to examine the values
    byte[] look()
     { return queue ; }

    byte serve()
     {
      byte temp = queue[front] ;
      front = next(front) ;
      count-- ;
      return temp;
     }// serve()

    boolean isEmpty()
     { return (count == 0) ; }// isEmpty()

    boolean isFull()
     { return (count == maxQueue) ; }// isFull()

    int next(int index)
     { return (index+1 < maxQueue ? index+1 : 0) ; }// next()

  }// class Queue

