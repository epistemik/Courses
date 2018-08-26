/*
File: Controller.java
Mark Sattolo  428500
CSI 3310  Assn#3 exercise 2 */

public class Controller
  {
   // constants for the traffic light colors
   private static final String RED = "RED", GREEN = "GREEN" ;

   // constants for the lock values and the queue limit
   private static final int NONE = 0, SOUTH = 1, NORTH = 2, LIMIT = 5 ;

   private int entered,     // number of cars in the tunnel
                  lock,     // the tunnel lock
              arrivals;     // number of cars arriving after the opposing queue is occupied

   // Strings for the traffic light values
   private String northLight, southLight ;

   // variables to hold the north and south queues
   private TrafficQueue northQueue, southQueue ;

   // constructor provides the queues
   Controller(TrafficQueue n, TrafficQueue s)
     {
      // initialize the counts and traffic lights
      entered = lock = arrivals = NONE ;
      northLight = RED ;
      southLight = GREEN ;
      // set the queues
      northQueue = n ;
      southQueue = s ;
     }

   synchronized String northbound_arrival()
     {
      switch(lock)
        {
         case SOUTH: // change the lights if necessary
                     if (northLight.equals(GREEN)) displayLights(RED, GREEN) ;
                     // other direction is travelling so cannot enter
                     return RED ;

         case NONE: // change the lights if necessary
                    if (!northLight.equals(southLight)) displayLights(GREEN, GREEN) ;
                    // traffic is now travelling north
                    lock = NORTH ;

         case NORTH: // if we have surpassed the allowed number to enter the tunnel
                     if (arrivals >= LIMIT)
                       {
                        // change the lights if necessary
                        if (!northLight.equals(southLight)) displayLights(RED, RED) ;
                        // no more cars can enter going north
                        return RED ;
                       }
                     // otherwise, change the lights if necessary
                     if (northLight.equals(RED)) displayLights(GREEN, RED) ;
                     // increment the number of arrivals
                     if (southQueue.occupied()) arrivals++ ;
                     break ;

         default: System.err.println("Invalid lock value.") ;
        }
      // keep track of the number of cars in the tunnel and allow new cars to enter
      entered++ ;
      return GREEN ;
     }

   synchronized String southbound_arrival()
     {
      switch(lock)
        {
         case NORTH: if (southLight.equals(GREEN)) displayLights(GREEN, RED) ;
                     return RED ;

         case NONE: if (!northLight.equals(southLight)) displayLights(GREEN, GREEN) ;
                    lock = SOUTH ;
                    //break ;

         case SOUTH: if (arrivals >= LIMIT)
                       {
                        if (!northLight.equals(southLight)) displayLights(RED, RED) ;
                        return RED ;
                       }
                     if (southLight.equals(RED)) displayLights(RED, GREEN) ;
                     if (northQueue.occupied()) arrivals++ ;
                     break ;

         default: System.err.println("Invalid lock value.") ;
        }
      entered++ ;
      return GREEN ;
     }

   synchronized void northbound_departure(int car_identification)
     {
      System.out.println("Northbound car " +  car_identification  + " is leaving the tunnel.") ;
      entered-- ;
      if (entered == 0) { if (southQueue.occupied()) lock = SOUTH ;
                          else lock = NONE ;
                          southQueue.cSignal() ;
                          arrivals = NONE ;
                        }
     }

   synchronized void southbound_departure(int car_identification)
     {
      System.out.println("Southbound car " +  car_identification  + " is leaving the tunnel.") ;
      entered-- ;
      if (entered == 0) { if (northQueue.occupied()) lock = NORTH ;
                          else lock = NONE ;
                          northQueue.cSignal() ;
                          arrivals = NONE ;
                        }
     }

   private void displayLights(String n, String s)
     {
      northLight = n ;
      southLight = s ;
      System.out.println("\n North light is " +  northLight  +
                          " & South light is " + southLight + ".\n") ;
     }

  }// class Controller

