
import java.util.Random;

class RandomTest {

  public static void main (String args[]) {

    int[] ndigits = new int[10];
    double x;
    int n;

    Random myRandom = new Random();

    // Initialize the array
    for (int i = 0; i < 10; i++) ndigits[i] = 0;

    // Test the random number generator a whole lot
    for (long i=0; i < 10000000; i++) {
      // generate a new random number between 0 and 9
      x = myRandom.nextDouble() * 10.0;
      n = (int) x;
      //count the digits in the random number
      ndigits[n]++;
    }
    // Print the results
    for (int i = 0; i < 10; i++) System.out.println(i+": " + ndigits[i]);

  }// main()

}//RandomTest
