class BoundedBuffer {        // designed for a single producer thread
                             // and a single consumer thread
   private int numSlots = 0;
   private double[] buffer = null;
   private int putIn = 0, takeOut = 0;
   private int count = 0;

   public BoundedBuffer(int numSlots) {
      if (numSlots <= 0) throw new IllegalArgumentException("numSlots<=0");
      this.numSlots = numSlots;
      buffer = new double[numSlots];
      System.out.println("BoundedBuffer alive, numSlots=" + numSlots);
   }

   public synchronized void deposit(double value) {
      while (count == numSlots)
         try {
            wait();
         } catch (InterruptedException e) {
            System.err.println("interrupted out of wait");
         }
      buffer[putIn] = value;
      putIn = (putIn + 1) % numSlots;
      count++;                   // wake up the consumer
      if (count == 1) notify();  // since it might be waiting
      System.out.println(" after deposit, count=" + count
         + ", putIn=" + putIn);
   }

   public synchronized double fetch() {
      double value;
      while (count == 0)
         try {
            wait();
         } catch (InterruptedException e) {
            System.err.println("interrupted out of wait");
         }
      value = buffer[takeOut];
      takeOut = (takeOut + 1) % numSlots;
      count--;                           // wake up the producer
      if (count == numSlots-1) notify(); // since it might be waiting
      System.out.println(" after fetch, count=" + count
         + ", takeOut=" + takeOut);
      return value;
   }
}

/* ............... Example compile and run(s)

D:\>javac bbmo.java bbpc.java

D:\>java ProducerConsumer -s 6 -p 2 -c 2 -R 10
ProducerConsumer: numSlots=6, pNap=2, cNap=2, runTime=10
BoundedBuffer alive, numSlots=6
All threads started
age=50, PRODUCER napping for 997 ms
age=110, Consumer napping for 1863 ms
age=1150, PRODUCER produced item 0.196652
 after deposit putIn=1
PRODUCER deposited item 0.196652
age=1150, PRODUCER napping for 1091 ms
age=2030, Consumer wants to consume
 after fetch takeOut=1
Consumer fetched item 0.196652
age=2030, Consumer napping for 439 ms
age=2250, PRODUCER produced item 0.268426
 after deposit putIn=2
PRODUCER deposited item 0.268426
age=2250, PRODUCER napping for 362 ms
age=2470, Consumer wants to consume
 after fetch takeOut=2
Consumer fetched item 0.268426
age=2470, Consumer napping for 946 ms
age=2630, PRODUCER produced item 0.958945
 after deposit putIn=3
PRODUCER deposited item 0.958945
age=2630, PRODUCER napping for 1939 ms
age=3400, Consumer wants to consume
 after fetch takeOut=3
Consumer fetched item 0.958945
age=3400, Consumer napping for 1312 ms
age=4610, PRODUCER produced item 0.078194
 after deposit putIn=4
PRODUCER deposited item 0.078194
age=4610, PRODUCER napping for 619 ms
age=4720, Consumer wants to consume
 after fetch takeOut=4
Consumer fetched item 0.078194
age=4720, Consumer napping for 576 ms
age=5220, PRODUCER produced item 0.0630488
 after deposit putIn=5
PRODUCER deposited item 0.0630488
age=5220, PRODUCER napping for 934 ms
age=5320, Consumer wants to consume
 after fetch takeOut=5
Consumer fetched item 0.0630488
age=5320, Consumer napping for 1993 ms
age=6150, PRODUCER produced item 0.580876
 after deposit putIn=0
PRODUCER deposited item 0.580876
age=6150, PRODUCER napping for 851 ms
age=7030, PRODUCER produced item 0.974548
 after deposit putIn=1
PRODUCER deposited item 0.974548
age=7030, PRODUCER napping for 1729 ms
age=7300, Consumer wants to consume
 after fetch takeOut=0
Consumer fetched item 0.580876
age=7300, Consumer napping for 496 ms
age=7850, Consumer wants to consume
 after fetch takeOut=1
Consumer fetched item 0.974548
age=7850, Consumer napping for 1480 ms
age=8730, PRODUCER produced item 0.0263791
 after deposit putIn=2
PRODUCER deposited item 0.0263791
age=8730, PRODUCER napping for 1249 ms
age=9330, Consumer wants to consume
 after fetch takeOut=2
Consumer fetched item 0.0263791
age=9330, Consumer napping for 1890 ms
age=9990, PRODUCER produced item 0.948153
 after deposit putIn=3
PRODUCER deposited item 0.948153
age=9990, PRODUCER napping for 1377 ms
age()=10050, time to stop the threads and exit
                                            ... end of example run(s)  */
