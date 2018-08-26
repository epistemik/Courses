
class PixelTest
 {
  public static void main(String args[])
   {
    Pixel p1 = new Pixel() ;
    Pixel p2 = new Pixel(33,66) ;
    Pixel p3 = new Pixel(9875) ;
    Pixel p4 = new Pixel(13,27,81) ;

    System.out.println("p2.x: " + p2.getx() + " and p2.y: " + p2.gety() + " and p2.color: " + p2.getcolor()) ;
    System.out.println("p3.x: " + p3.getx() + " and p3.y: " + p3.gety() + " and p3.color: " + p3.getcolor()) ;
    System.out.println("p4.x: " + p4.getx() + " and p4.y: " + p4.gety() + " and p4.color: " + p4.getcolor()) ;

    for (int i=0; i<10; i++)
      {
       p1.setx(i) ;
       System.out.println("p1.x: " + p1.getx()) ;
       p1.sety(i) ;
       System.out.println("p1.y: " + p1.gety()) ;
       p1.setcolor(i) ;
       System.out.println("p1.color: " + p1.getcolor()) ;
      }

   }//main()

 }//class PixelTest