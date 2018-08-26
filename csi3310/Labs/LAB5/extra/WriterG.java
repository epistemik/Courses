
class WriterG extends Thread
 {
  Semafore s1, s2 ;
  String myName ;

  WriterG(Semafore w, Semafore r, String name) // constructor
    {
     s1 = w ;
     s2 = r ;
     myName = name ;
    }

  public void run()
    {
     while (true)
       {
        synchronized (s1) { s2.check(0, myName) ;
        s1.take(0, myName) ; }
        System.out.println("Writer " + myName + " is writing.") ;
        System.out.println("There are " + s2.count() + " readers and "
                            + s1.count() + " writers.\n") ;
        try { sleep( (int)(Math.random()*50) ) ; }
        catch (Exception e) { System.err.println("WritingError: " + e) ; }
        s1.release(myName) ;
        System.out.println("Writer " + myName + " has finished writing.\n") ;
        try { sleep( 10 + (int)(Math.random()*90) ) ; }
        catch (Exception e) { System.err.println("WriterError: " + e) ; }
       }
    }// run()

 }// class WriterG
