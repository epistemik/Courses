
class ExceptionTest
 {
  public static void main(String args[])
   {
    try
       {
        int i = Integer.parseInt(args[0]) ;
        System.out.println(" \n " + args[0] + " * 2 = " + (i*2) ) ;
       }
    catch (NumberFormatException n)
      {
       System.out.println(" \n " + args[0] + " is not an integer!" ) ;
      }

   }//main()

 }//class ExceptionTest