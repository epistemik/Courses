
class Writer2 extends Thread
 {
  Semafor2 mySemafor ;
  String myName ;

  Writer2(Semafor2 s, String name) // constructor
    {
     mySemafor = s ;
     myName = name ;
    }

  public void run()
    {
     while (true)
       {
        mySemafor.writeTake(myName) ;
        try { sleep( (int)(Math.random()*50) ) ; }
        catch (Exception e) { System.err.println("Write2Error: " + e) ; }
        mySemafor.writeRelease(myName) ;
        try { sleep( 10 + (int)(Math.random()*90) ) ; }
        catch (Exception e) { System.err.println("Writer2Error: " + e) ; }
       }
    }// run()

 }// class Writer2
