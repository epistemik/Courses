
class Catch2Test
 {
  public static void main(String args[])
   {
    try
       {
        int i = Integer.parseInt(args[0]) ;
        System.out.println(" \n arg #" + i + " is '" + args[i] + "' " ) ;
       }
    catch (NumberFormatException n)
      {
       System.out.println(" \n " + args[0] + " is not an integer!" ) ;
      }
    catch (ArrayIndexOutOfBoundsException a)
      {
       System.out.println(" \n There is no argument #" + Integer.parseInt(args[0]) + " !" ) ;
      }

   }//main()

 }//class Catch2Test