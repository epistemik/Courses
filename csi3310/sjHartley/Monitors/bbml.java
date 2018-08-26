import Utilities.*;

class Producer extends MyObject implements Runnable {

   private int pNap = 0; // milliseconds
   private BoundedBuffer bb = null;

   public Producer(String name, int pNap, BoundedBuffer bb) {
      super(name);
      this.pNap = pNap;
      this.bb = bb;
      new Thread(this).start();
   }

   public void run() {
      double item;
      int napping;
      while (true) {
         napping = 1 + (int) random(pNap);
         System.out.println("age=" + age() + ", " + getName()
            + " napping for " + napping + " ms");
         nap(napping);
         item = random();
         System.out.println("age=" + age() + ", " + getName()
            + " produced item " + item);
         bb.deposit(item);
         System.out.println("age=" + age() + ", " + getName()
            + " deposited item " + item);
      }
   }
}

class Consumer extends MyObject implements Runnable {

   private int cNap = 0; // milliseconds
   private BoundedBuffer bb = null;

   public Consumer(String name, int cNap, BoundedBuffer bb) {
      super(name);
      this.cNap = cNap;
      this.bb = bb;
      new Thread(this).start();
   }

   public void run() {
      double item;
      int napping;
      while (true) {
         napping = 1 + (int) random(cNap);
         System.out.println("age=" + age() + ", " + getName()
            + " napping for " + napping + " ms");
         nap(napping);
         System.out.println("age=" + age() + ", " + getName()
            + " wants to consume");
         item = bb.fetch();
         System.out.println("age=" + age() + ", " + getName()
            + " fetched item " + item);
      }
   }
}

class ProducersConsumers extends MyObject {

   public static void main(String[] args) {

      // parse command line arguments, if any, to override defaults
      GetOpt go = new GetOpt(args, "Us:P:C:p:c:R:");
      go.optErr = true;
      String usage =
         "Usage: -s numSlots -P numP -C numC -p pNap -c cNap -R runTime";
      int ch = -1;
      int numSlots = 20;
      int numProducers = 2;
      int numConsumers = 3;
      int pNap = 3;       // defaults
      int cNap = 2;       // in
      int runTime = 60;   // seconds
      while ((ch = go.getopt()) != go.optEOF) {
         if      ((char)ch == 'U') {
            System.out.println(usage);  System.exit(0);
         }
         else if ((char)ch == 's')
            numSlots = go.processArg(go.optArgGet(), numSlots);
         else if ((char)ch == 'P')
            numProducers = go.processArg(go.optArgGet(), numProducers);
         else if ((char)ch == 'C')
            numConsumers = go.processArg(go.optArgGet(), numConsumers);
         else if ((char)ch == 'p')
            pNap = go.processArg(go.optArgGet(), pNap);
         else if ((char)ch == 'c')
            cNap = go.processArg(go.optArgGet(), cNap);
         else if ((char)ch == 'R')
            runTime = go.processArg(go.optArgGet(), runTime);
         else {
            System.err.println(usage);  System.exit(1);
         }
      }
      System.out.println("ProducersConsumers:\n numSlots=" + numSlots
         + ", numProducers=" + numProducers
         + ", numConsumers=" + numConsumers
         + ", pNap=" + pNap + ", cNap=" + cNap + ", runTime=" + runTime);

      // create the bounded buffer
      BoundedBuffer bb = new BoundedBuffer(numSlots);

      // start the Producer and Consumer threads
      for (int i = 0; i < numProducers; i++)
         new Producer("PRODUCER"+i, pNap*1000, bb);
      for (int i = 0; i < numConsumers; i++)
         new Consumer("Consumer"+i, cNap*1000, bb);
      System.out.println("All threads started");

      // let them run for a while
      nap(runTime*1000);
      System.out.println("age()=" + age()
         + ", time to stop the threads and exit");
      System.exit(0);
   }
}
