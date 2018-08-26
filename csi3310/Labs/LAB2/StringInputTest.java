
import java.io.*  ;
import java.util.*  ;

class StringInputTest
 {
  public static void main(String args[])
   {
    DataInput str ;
    String buff ;
    StringTokenizer tok ;
    System.out.println("Please enter some integers then press 'Enter' ") ;
    try
       {
        str = new DataInputStream(System.in) ;
        buff = str.readLine() ;
        tok = new StringTokenizer(buff) ;
        while ( tok.hasMoreTokens() )
          {
           System.out.println(" \n The input was '" + tok.nextToken() + "' " ) ;
          }
        }
    catch (Exception e)
      {
       System.out.println(" Sorry, but that did not work! " ) ;
       System.out.println(e) ;
      }

   }//main()

 }//class StringInputTest