/*
File: Tunnel.java
Mark Sattolo  428500
CSI 3310  Assn#3 exercise 1 */

class Tunnel
 {
  // boolean constant for each direction
  private final static boolean NORTH = true,
                               SOUTH = false ;

  // constants for the number of cars
  private final static int NORTH_CARS = 3,
                           SOUTH_CARS = 3,
                           TOTAL_CARS = SOUTH_CARS + NORTH_CARS ;

  public static void main(String[] args)
   {
    // initialize the TrafficQueues and the Controller
    TrafficQueue northQueue = new TrafficQueue() ;
    TrafficQueue southQueue = new TrafficQueue() ;
    Controller monitor = new Controller(northQueue, southQueue) ;

    // create the Cars
    Car[] auto = new Car[TOTAL_CARS] ;
    for (int i=0; i < NORTH_CARS ; i++)
       auto[i] = new Car(monitor, northQueue, NORTH, i) ;
    for (int i=0; i < SOUTH_CARS ; i++)
       auto[i+NORTH_CARS] = new Car(monitor, southQueue, SOUTH, i) ;

    // show the initial state of the traffic lights   
    monitor.displayLights() ;

    // start the Car threads
    for (int i=0; i < TOTAL_CARS ; i++)
       auto[i].start() ;

   }// main()

 }// class Tunnel

