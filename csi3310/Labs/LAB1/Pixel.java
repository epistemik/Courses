
class Pixel extends Point
 {
  private int color ;

  Pixel()
   { super() ;
     color = 27 ; }

  Pixel(int x, int y)
   { super(x, y) ;
     color = 3 ; }

  Pixel(int v)
   { super(v) ;
     color = v ; }

  Pixel(int x, int y, int c)
   { super(x, y) ;
     color = c ;
   }

  public void setcolor(int c)
   { color = c ;
   }

  public int getcolor()
   { return this.color ;
   }

 }//class Pixel
