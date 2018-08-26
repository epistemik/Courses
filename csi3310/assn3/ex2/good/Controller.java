/*
File: Controller.java
Mark Sattolo  428500
CSI 3310  Assn#3 exercise 2 */

public class Controller
  {
   // constants for the traffic light colors
   private static final String RED = "RED", GREEN = "GREEN" ;

   /* an integer to hold the count for each direction and
      one for the number of cars arriving after cars are in the other queue */
   private int north, south,
               northArrivals, southArrivals ;

   // Strings for the traffic light values
   private String northLight, southLight ;

   // variables to hold the north and south queues
   private TrafficQueue northQueue, southQueue ;

   // constructor provides the queues
   Controller(TrafficQueue n, TrafficQueue s)
     {
      // initialize the counts and traffic lights
      north = south = northArrivals = southArrivals = 0 ;
      northLight = southLight = GREEN ;
      // set the queues
      northQueue = n ;
      southQueue = s ;
     }

   synchronized String northbound_arrival()
     {
      if ( (north > 0 && southQueue.occupied()) || northArrivals > 0 )
        { northArrivals++ ;
         //  System.out.println("\t North arrivals == " + northArrivals) ;
          }
      if ( south > 0 || northArrivals > 5 )
        {
         // change the lights at the 6th car
         if (northArrivals == 6) displayLights(RED, RED) ;
         // return RED to the 6th and subsequent cars
         return RED ;
        }
      if ( (northLight.equals(RED) || southLight.equals(GREEN)) && south == 0 )
        {
         displayLights(GREEN, RED) ;
         southArrivals = 0 ;
        }
      north++ ;
      return GREEN ;
     }

   synchronized String southbound_arrival()
     {
      if ( (south > 0 && northQueue.occupied()) || southArrivals > 0 )
        { southArrivals++ ;
         //  System.out.println("\t South arrivals == " + southArrivals) ;
          }
      if ( north > 0 || southArrivals > 5 )
        {
         // change the lights at the 6th car
         if (southArrivals == 6) displayLights(RED, RED) ;
         // return RED to the 6th and subsequent cars
         return RED ;
        }
      if ( (southLight.equals(RED) || northLight.equals(GREEN)) && north == 0 )
        {
         displayLights(RED, GREEN) ;
         northArrivals = 0 ;
        }
      south++ ;
      return GREEN ;
     }

   synchronized void northbound_departure(int car_identification)
     {
      System.out.println("Northbound car " +  car_identification  + " is leaving the tunnel.") ;
      north-- ;
      if (north == 0)
        {
         southQueue.cSignal() ;
       //  northArrivals = 0 ;
        }
     }

   synchronized void southbound_departure(int car_identification)
     {
      System.out.println("Southbound car " +  car_identification  + " is leaving the tunnel.") ;
      south-- ;
      if (south == 0)
        {
         northQueue.cSignal() ;
       //  southArrivals = 0 ;
        }
     }

   void displayLights()
     { System.out.println("\n North light is " +  northLight  +
                          " & South light is " + southLight + ".\n") ; }

   private void displayLights(String n, String s)
     {
      northLight = n ;
      southLight = s ;
      System.out.println("\n North light is " +  northLight  +
                          " & South light is " + southLight + ".\n") ;
     }

  }// class Controller

