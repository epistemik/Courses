
class Reader2 extends Thread
 {
  Semafor2 mySemafor ;
  String myName ;

  Reader2(Semafor2 s, String name) // constructor
    {
     mySemafor = s ;
     myName = name ;
    }

  public void run()
    {
     while (true)
       {
        mySemafor.readTake(myName) ;
        try { sleep( (int)(Math.random()*50) ) ; }
        catch (Exception e) { System.err.println("Read2Error: " + e) ; }
        mySemafor.readRelease(myName) ;
        try { sleep( 10 + (int)(Math.random()*90) ) ; }
        catch (Exception e) { System.err.println("Reader2Error: " + e) ; }
       }
    }// run()

 }// class Reader2
