
class Point
 {
  private int x, y ;

  Point()
   { x = 0 ;
     y = 0 ;
   }

  Point(int x, int y)
   { this.x = x ;
     this.y = y ;
   }

  Point(int v)
   { this.x = this.y = v ;
   }

  public void setx(int x)
   { this.x = x ;
   }

  public int getx()
   { return this.x ;
   }

  public void sety(int y)
   { this.y = y ;
   }

  public int gety()
   { return this.y ;
   }

 }//class Point