
class CommandTest
 {
  public static void main(String args[])
   {
    System.out.println("\n There are " + args.length + " args on the command line. \n") ;
    for (int i=0; i < args.length ; i++)
      {
       System.out.println("arg #" + (i+1) + " is '" + args[i] + "'") ;
      }

   }//main()

 }//class CommandTest