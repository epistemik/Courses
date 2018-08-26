
class PointTest2
 {
  public static void main(String args[])
   {
    Point p1 = new Point() ;
    Point p2 = new Point(33,66) ;
    Point p3 = new Point(9875) ;

    System.out.println("p2.x: " + p2.getx() + " - p2.y: " + p2.gety()) ;
    System.out.println("p3.x: " + p3.getx() + " - p3.y: " + p3.gety()) ;

    for (int i=0; i<10; i++)
      {
       p1.setx(i) ;
       System.out.println("p1.x: " + p1.getx()) ;
       p1.sety(i) ;
       System.out.println("p1.y: " + p1.gety()) ;
      }

   }//main()

 }//class PointTest2