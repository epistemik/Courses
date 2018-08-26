
import java.io.*  ;

class KeyInputTest
 {
  public static void main(String args[])
   {
    DataInput str ;
    String buff ;
    System.out.println("Please enter some info then press 'Enter' ") ;
    try
       {
        str = new DataInputStream(System.in) ;
        buff = str.readLine() ;
        System.out.println(" \n The input was '" + buff + "' " ) ;
       }
    catch (Exception e)
      {
       System.out.println(" Sorry, but that did not work! " ) ;
       System.out.println(e) ;
      }

   }//main()

 }//class KeyInputTest