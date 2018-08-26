
import java.io.*  ;
import java.util.*  ;

class StringInput2Test
 {
  public static void main(String args[])
   {
    DataInput str ;
    String buff ;
    StringTokenizer tok ;
    System.out.println("Please enter some numbers then press 'Enter' ") ;
    try
       {
        str = new DataInputStream(System.in) ;
        buff = str.readLine() ;
        tok = new StringTokenizer(buff) ;
        int i = 1 ;
        while ( tok.hasMoreTokens() )
          {
           System.out.println(" \n Item #" + i + " was '" + tok.nextToken() + "' " ) ;
           i++ ;
          }
        }
    catch (Exception e)
      {
       System.out.println(" Sorry, but that did not work! " ) ;
       System.out.println(e) ;
      }

   }//main()

 }//class StringInput2Test