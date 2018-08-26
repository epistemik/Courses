/*
File: Car.java
Mark Sattolo  428500
CSI 3310  Assn#3 exercise 1 */

class Car extends Thread
  {
   // constants for the sleep() intervals
   private static final int MIN_SLEEP = 1, SLEEP_TIME = 5 ;

   private boolean north ;

   private int idNumber ;

   private String trafficLight, direction ;

   private TrafficQueue myQueue ;

   // the monitor
   private Controller trafficMonitor ;

   Car(Controller c, TrafficQueue q, int id) // constructor
     {
      // initialize all the Car variables
      idNumber = id ;
      myQueue = q ;
      north = q.getDirection() ;
      trafficMonitor = c ;
      direction = north ? "North" : "South" ;
     }

    public void run()
     {
      while (true)  // continue forever
        {
         try
           {
            while ( (trafficLight = north ? trafficMonitor.northbound_arrival()
                                          : trafficMonitor.southbound_arrival()).equals("RED") )
                 myQueue.cWait() ;

            System.out.println(direction + "bound car " + idNumber + " is entering the tunnel.") ;

            // sleep 1 ms while in the tunnel
            sleep(MIN_SLEEP) ;

            // signal leaving the tunnel
            if (north) trafficMonitor.northbound_departure(idNumber) ;
            else trafficMonitor.southbound_departure(idNumber) ;

            // sleep 1-5 ms before re-entering the tunnel
            sleep( MIN_SLEEP + (int)(Math.random() * SLEEP_TIME) ) ;
           }

         // catch any exceptions
         catch (Exception e) { System.err.println("Car.run()Error: " + e) ; }

        }// endwhile

     }// run()

  } // class Car

