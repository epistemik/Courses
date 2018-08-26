
public class FiveThreadsTest
 {
  public static void main (String[] args)
    {
     new SimpleThread("Bonaire").start();
     new SimpleThread("Maui").start();
     new SimpleThread("Jamaica").start();
     new SimpleThread("Fiji").start();
     new SimpleThread("Bora Bora").start();
    }
 }
