
class Fibonacci
 {
  public static void main (String args[])
   {
    int low = 1;
    int high = 1;
    System.out.println(low);
    while (high < 150)
     {
      System.out.println(high);
      int temp = high;
      high = high + low;
      low = temp;
     }

   }
 }
