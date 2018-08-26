/*
File: Monitor.java
Mark Sattolo  428500
CSI 3310  Assn#3 exercise 1 */

public class Monitor
  {
   // constants for the traffic light colors
   private static final String RED = "RED", GREEN = "GREEN" ;

   // constants to identify the lock value
   private static final int NONE = 0, SOUTH = 1, NORTH = 2 ;

   // an integer to hold the count for each direction and the tunnel lock
   private int entered, lock ;

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
         case SOUTH: if (northLight.equals(GREEN)) displayLights(RED, GREEN) ;
                     return RED ;

         case NONE: if (!northLight.equals(southLight)) displayLights(GREEN, GREEN) ;
                    lock = NORTH ;

         case NORTH: if (northLight.equals(RED)) displayLights(GREEN, RED) ;
                     entered++ ;
                     break ;

         default: System.err.println("Invalid lock value: " + lock) ;
        }
      return GREEN ;
     }

   public synchronized String southbound_arrival()
     {
      switch(lock)
        {
         case NORTH: if (southLight.equals(GREEN)) displayLights(GREEN, RED) ;
                     return RED ;

         case NONE: if (!northLight.equals(southLight)) displayLights(GREEN, GREEN) ;
                    lock = SOUTH ;

         case SOUTH: if (southLight.equals(RED)) displayLights(RED, GREEN) ;
                     entered++ ;
                     break ;

         default: System.err.println("Invalid lock value: " + lock) ;
        }
      return GREEN ;
     }

   public synchronized void northbound_departure(int car_identification)
     {
      System.out.println("Northbound car " +  car_identification  + " is leaving the tunnel.") ;
      entered-- ;
      if (entered == 0) { if (southQueue.occupied())
                            { lock = SOUTH ;
                              southQueue.cSignal() ; }
                          else lock = NONE ; }
     }

   public synchronized void southbound_departure(int car_identification)
     {
      System.out.println("Southbound car " +  car_identification  + " is leaving the tunnel.") ;
      entered-- ;
      if (entered == 0) { if (northQueue.occupied())
                            { lock = NORTH ;
                              northQueue.cSignal() ; }
                          else lock = NONE ; }
     }

   private void displayLights(String n, String s)
     {
      northLight = n ;
      southLight = s ;
      System.out.println("\n North light is " +  northLight  +
                          " & South light is " + southLight + ".\n") ;
     }

  }// class Monitor

