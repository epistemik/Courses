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
      while (myPapers.index < myPapers.capacity)
      {
      if (mySemaphore.redFree < 0) System.err.println("Red overrun!") ;
      if (mySemaphore.greenFree < 0) System.err.println("Green overrun!") ;
      if (mySemaphore.yellowFree < 0) System.err.println("Yellow overrun!") ;
      if (mySemaphore.blueFree < 0) System.err.println("Blue overrun!") ;

      if (mySemaphore.redFree + mySemaphore.greenFree
          + mySemaphore.yellowFree + mySemaphore.blueFree == 12)
         System.out.println("\n All pencils taken. \n") ;
      try { sleep(5) ; } catch (Exception e) { System.err.println("VerifyError: " + e) ; }
      }
     }

  } // class Jury

