/*
File: Verify.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

class Verify extends Thread
  {
   ColorSemaphore mySemaphore ;
   Paper myPapers ;

   // constructor supplies Paper, Drawings & capacity
   Verify(ColorSemaphore c, Paper p)
     {
      mySemaphore = c ;
      myPapers = p ;
     }

   public void run()
     {
      int total ;
      while (myPapers.index < myPapers.capacity)
      {
      if (mySemaphore.redCount < 0) System.err.println("Red overrun!") ;
      if (mySemaphore.greenCount < 0) System.err.println("Green overrun!") ;
      if (mySemaphore.yellowCount < 0) System.err.println("Yellow overrun!") ;
      if (mySemaphore.blueCount < 0) System.err.println("Blue overrun!") ;

      total = (mySemaphore.redCount + mySemaphore.greenCount + mySemaphore.yellowCount
               + mySemaphore.blueCount ) ;
      System.out.println("\n Verify running, total is " + total + " \n") ;
      if (mySemaphore.redCount + mySemaphore.greenCount + mySemaphore.yellowCount
          + mySemaphore.blueCount == 0) System.out.println("\n All pencils taken. \n") ;
      if (mySemaphore.redCount + mySemaphore.greenCount + mySemaphore.yellowCount
          + mySemaphore.blueCount < 0) System.out.println("\n Pencil overrun! \n") ;
      try { sleep(3) ; } catch (Exception e) { System.err.println("VerifyError: " + e) ; }
      }
     }

  } // class Verify

