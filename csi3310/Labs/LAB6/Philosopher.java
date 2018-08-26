
class Philosopher extends Thread
 {
  Chopstick left, right ;

  Philosopher(Chopstick l, Chopstick r, String name) // constructor
    {
     super(name) ;
     left = l ;
     right = r ;
    }

  public void run()
    {
     while (true)
       {
        left.take() ;
        System.out.println(getName() + " has the left chopstick.") ;
        try { sleep( (int)(Math.random()*3) ) ; }
        catch (Exception e) { System.err.println("LeftError: " + e) ; }
        right.take() ;
        System.out.println(getName() + " has the right chopstick.") ;
        System.out.println(getName() + " is eating.") ;
        try { sleep( (int)(Math.random()*50) ) ; }
        catch (Exception e) { System.err.println("RightError: " + e) ; }
        left.release() ;
        right.release() ;
        try { sleep( 10 + (int)(Math.random()*30) ) ; }
        catch (Exception e) { System.err.println("PhilosopherError: " + e) ; }
       }
    }// run()

 }// class Philosopher
