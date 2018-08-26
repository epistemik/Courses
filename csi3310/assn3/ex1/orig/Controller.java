/*
File: Controller.java
Mark Sattolo  428500
CSI 3310  Assn#3 exercise 1 */

public class Controller
  {
   // constants for the traffic light colors
   private static final String RED = "RED", GREEN = "GREEN" ;

   // an integer to hold the count for each direction
   private int north, south ;

   // Strings for the traffic light values
   private String northLight, southLight ;

   // variables to hold the north and south queues
   private TrafficQueue northQueue, southQueue ;

   // constructor provides the queues
   Controller(TrafficQueue n, TrafficQueue s)
     {
      // initialize the counts and traffic lights
      north = south = 0 ;
      northLight = southLight = GREEN ;
      // set the queues
      northQueue = n ;
      southQueue = s ;
     }

   synchronized String northbound_arrival()
     {
      if (south > 0)
        return RED ;
      if (northLight == RED || southLight == GREEN)
        {
         northLight = GREEN ;
         southLight = RED ;
         displayLights() ;
        }
      north++ ;
      return GREEN ;
     }

   synchronized String southbound_arrival()
     {
      if (north > 0)
        return RED ;
      if (southLight == RED || northLight == GREEN)
        {
         southLight = GREEN ;
         northLight = RED ;
         displayLights() ;
        }
      south++ ;
      return GREEN ;
     }

   synchronized void northbound_departure(int car_identification)
     {
      System.out.println("Northbound car " +  car_identification  + " is leaving the tunnel.") ;
      north-- ;
      if (north == 0) southQueue.cSignal() ;
     }

   synchronized void southbound_departure(int car_identification)
     {
      System.out.println("Southbound car " +  car_identification  + " is leaving the tunnel.") ;
      south-- ;
      if (south == 0) northQueue.cSignal() ;
     }

   //private
   void displayLights()
     { System.out.println("\n North light is " +  northLight  +
                          " & South light is " + southLight + ".\n") ; }


  }// class Controller

