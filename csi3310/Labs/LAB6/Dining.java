
class Dining
 {
  private static final int NUM_STICKS = 5 ;

  public static void main(String[] args)
   {
    Chopstick[] eat = new Chopstick[NUM_STICKS] ;
    for (int i = 0; i < NUM_STICKS; i++) eat[i] = new Chopstick() ;

    Philosopher think1 = new Philosopher(eat[0], eat[1], "Plato") ;
    Philosopher think2 = new Philosopher(eat[1], eat[2], "Rene") ;
    Philosopher think3 = new Philosopher(eat[2], eat[3], "Benedict") ;
    Philosopher think4 = new Philosopher(eat[3], eat[4], "David") ;
    Philosopher think5 = new Philosopher(eat[4], eat[0], "Ludwig") ;

    think1.start() ;
    think2.start() ;
    think3.start() ;
    think4.start() ;
    think5.start() ;

   }// main()

 }// class Dining

