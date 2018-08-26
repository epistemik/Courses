
class Reader extends Thread
 {
  Semafor mySemafor ;
  String myName ;

  Reader(Semafor s, String name) // constructor
    {
     mySemafor = s ;
     myName = name ;
    }

  public void run()
    {
     while (true)
       {
        mySemafor.readTake() ;
        System.out.println("Reader " + myName + " is reading.\n") ;
        try { sleep( (int)(Math.random()*50) ) ; }
        catch (Exception e) { System.err.println("ReadError: " + e) ; }
        mySemafor.readRelease() ;
        try { sleep( 10 + (int)(Math.random()*90) ) ; }
        catch (Exception e) { System.err.println("ReaderError: " + e) ; }
       }
    }// run()

 }// class Reader
