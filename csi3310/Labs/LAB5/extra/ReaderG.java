
class ReaderG extends Thread
 {
  Semafore s1, s2 ;
  String myName ;

  ReaderG(Semafore r, Semafore w, String name) // constructor
    {
     s1 = r ;
     s2 = w ;
     myName = name ;
    }

  public void run()
    {
     while (true)
       {
        synchronized (s1) { s2.check(0, myName) ;
        s1.take(3, myName) ; }
        System.out.println("Reader " + myName + " is reading.") ;
        System.out.println("There are " + s1.count() + " readers and "
                            + s2.count() + " writers.\n") ;
        try { sleep( (int)(Math.random()*50) ) ; }
        catch (Exception e) { System.err.println("ReadingError: " + e) ; }
        s1.release(myName) ;
        System.out.println("Reader " + myName + " has finished reading.\n") ;
        try { sleep( 10 + (int)(Math.random()*90) ) ; }
        catch (Exception e) { System.err.println("ReaderError: " + e) ; }
       }
    }// run()

 }// class ReaderG
