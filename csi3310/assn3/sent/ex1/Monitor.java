/*
File: Monitor.java
Mark Sattolo  428500
CSI 3310  Assn#3 exercise 1 */

public class Monitor
  {
   // constants for the traffic light colors
   private static final String RED = "RED", GREEN = "GREEN" ;

   // constants to identify the condition of the tunnel lock
   private static final int NONE = 0, SOUTH = 1, NORTH = 2 ;

   private int entered,   // an integer to hold the number in the tunnel
                 lock ;   // the tunnel lock

   // Strings for the traffic light values
   private String northLight, southLight ;

   // variables to hold the north and south queues
   private TrafficQueue northQueue, southQueue ;

   // constructor provides the queues
   Monitor(TrafficQueue n, TrafficQueue s)
     {
      // initialize the counts and traffic lights
      entered = lock = NONE ;
      northLight = RED ;
      southLight = GREEN ;
      // set the queues
      northQueue = n ;
      southQueue = s ;
     }

   public synchronized String northbound_arrival()
     {
      switch(lock)
        {
         case SOUTH: // change the lights if the wrong direction has GREEN
                     if (northLight.equals(GREEN)) displayLights(RED, GREEN) ;
                     // other direction is travelling so cannot enter
                     return RED ;

         case NONE: // change the lights if necessary
                    if (!northLight.equals(southLight)) displayLights(GREEN, GREEN) ;
                    // traffic is now travelling north
                    lock = NORTH ;
                    // fall through to increment the number in the tunnel

         case NORTH: // change the lights if the wrong direction has RED
                     if (northLight.equals(RED)) displayLights(GREEN, RED) ;
                     // increment the number of arrivals
                     entered++ ;
                     break ;

         default: System.err.println("Invalid lock value: " + lock) ;
        }
      // allow traffic to enter
      return GREEN ;
     }

   public synchronized String southbound_arrival()
     {
      switch(lock)
        {
         case NORTH: // change the lights if wrong direction has GREEN
                     if (southLight.equals(GREEN)) displayLights(GREEN, RED) ;
                     // other direction is travelling so cannot enter
                     return RED ;

         case NONE: // change the lights if necessary
                    if (!northLight.equals(southLight)) displayLights(GREEN, GREEN) ;
                    // traffic is now travelling south
                    lock = SOUTH ;
                    // fall through to increment the number in the tunnel

         case SOUTH: // change the lights if wrong direction has RED
                     if (southLight.equals(RED)) displayLights(RED, GREEN) ;
                     // increment the number of arrivals
                     entered++ ;
                     break ;

         default: System.err.println("Invalid lock value: " + lock) ;
        }
      // allow traffic to enter
      return GREEN ;
     }

   public synchronized void northbound_departure(int car_identification)
     {
      // print a message
      System.out.println("Northbound car " +  car_identification  + " is leaving the tunnel.") ;
      // decrement the number in the tunnel
      entered-- ;
      // if the tunnel is now empty...
      if (entered == 0) { if (southQueue.occupied())
                          /* if southbound traffic is waiting, give South the lock and
                             signal the South threads */
                            { lock = SOUTH ;
                              southQueue.cSignal() ; }
                          // otherwise the first Car is free to enter
                          else lock = NONE ; }
     }

   public synchronized void southbound_departure(int car_identification)
     {
      // print a message
      System.out.println("Southbound car " +  car_identification  + " is leaving the tunnel.") ;
      // decrement the number in the tunnel
      entered-- ;
      // if the tunnel is now empty...
      if (entered == 0) { if (northQueue.occupied())
                          /* if northbound traffic is waiting, give North the lock and
                             signal the North threads */
                            { lock = NORTH ;
                              northQueue.cSignal() ; }
                          // otherwise the first Car is free to enter
                          else lock = NONE ; }
     }

   private void displayLights(String n, String s)
     {
      // set the lights and print a display message
      northLight = n ;
      southLight = s ;
      System.out.println("\n North light is " +  northLight  +
                          " & South light is " + southLight + ".\n") ;
     }

  }// class Monitor

