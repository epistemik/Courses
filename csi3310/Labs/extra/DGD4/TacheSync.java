import java.io.*;
import java.lang.*;
import java.lang.Thread.*;

class TacheSync extends Thread {

  TacheSync(String name) {
    /* call of the super class constructor (Thread) */
    super();
    /* setting the name */
    setName(name);
  }

 /* redefinition of the run() method */
 public void run() {
    /* call of the compte method (synchronized) */
    compte(getName());
  }

  public synchronized void compte(String name) {
    for(int i=0; i<10; i++) {
      System.out.println(name+"("+i+")");
    }
  }


  public static void main(String args[]) {
    /* creation of two tasks t1 et t2 */
    TacheNonSync t1 = new TacheNonSync("t1");
    TacheNonSync t2 = new TacheNonSync("t2");
    
    /* starting of the tasks */
    t1.start();
    t2.start();

    /* call the the compte() method of t1 */
    t1.compte("main");

    System.out.println("Here, printout of t1 and main WILL NOT interleave");

  }


}
