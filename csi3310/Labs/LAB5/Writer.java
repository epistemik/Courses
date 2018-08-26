
class Writer extends Thread
 {
  Semafor mySemafor ;
  String myName ;

  Writer(Semafor s, String name) // constructor
    {
     mySemafor = s ;
     myName = name ;
    }

  public void run()
    {
     while (true)
       {
        mySemafor.writeTake() ;
        System.out.println("Writer " + myName + " is writing.\n") ;
        try { sleep( (int)(Math.random()*50) ) ; }
        catch (Exception e) { System.err.println("WriteError: " + e) ; }
        mySemafor.writeRelease() ;
        try { sleep( 10 + (int)(Math.random()*90) ) ; }
        catch (Exception e) { System.err.println("WriterError: " + e) ; }
       }
    }// run()

 }// class Writer
