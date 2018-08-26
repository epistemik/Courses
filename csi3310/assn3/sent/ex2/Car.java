/*
File: Car.java
Mark Sattolo  428500
CSI 3310  Assn#3 exercise 2 */

class Car extends Thread
  {
   // constants for the sleep() intervals
   private static final int MIN_SLEEP = 1, SLEEP_TIME = 5 ;

   // identify which direction a car is travelling
   private boolean northbound ;

   // an integer for each car
   private int car_identification ;

   // string variables for the traffic light and direction
   private String trafficLight, direction ;

   // the queue
   private TrafficQueue myQueue ;

   // the monitor
   private Monitor controller ;

   Car(Monitor m, TrafficQueue q, int id) // constructor
     {
      // initialize all the Car variables
      controller = m ;
      car_identification = id ;
      myQueue = q ;
      // Queue supplies the direction
      northbound = q.getDirection() ;
      direction = northbound ? "Northbound" : "Southbound" ;
     }

    public void run()
     {
      while (true)  // a Car must loop through the following actions forever
        {
         try
           {
            while ( (trafficLight = northbound ? controller.northbound_arrival()
                                               : controller.southbound_arrival()).equals("RED") )
                 // Car must wait in queue while the arrival method returns RED
                 myQueue.cWait() ;

            // trafficLight was GREEN so Car enters tunnel and prints out a message
            System.out.println(direction + " car " + car_identification + " is entering the tunnel.") ;

            // sleep 1 ms while in the tunnel
            sleep(MIN_SLEEP) ;

            // signal leaving the tunnel
            if (northbound) controller.northbound_departure(car_identification) ;
            else controller.southbound_departure(car_identification) ;

            // sleep 1-5 ms before re-entering the tunnel
            sleep( MIN_SLEEP + (int)(Math.random() * SLEEP_TIME) ) ;
           }

         // catch any exceptions
         catch (Exception e) { System.err.println("Car.run()Error: " + e) ; }

        }// endwhile

     }// run()

  } // class Car

