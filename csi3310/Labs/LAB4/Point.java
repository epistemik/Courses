
class Point
 {
  private int x, y ;

  Point()  // constructor
   { x = 0 ;
     y = 0 ; }

  Point(int x, int y) // constructor 2
   { this.x = x ;
     this.y = y ; }

  Point(int v)
   { this.x = this.y = v ; } // constructor 3

  public synchronized void setX(int x)
   {
    System.out.println("Setting x to " + x) ;
    try { Thread.sleep(3000) ; }
    catch (Exception e) { System.err.println("Error: " + e) ; }
    System.out.println("x has been set!") ;
   }

  public int getX()
   { return this.x ; }

  public void setY(int y)
   { this.y = y ; }

  public int getY()
   { return this.y ; }

 }//class Point