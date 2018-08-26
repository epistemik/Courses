import java.io.*;
import java.lang.*;

class ThreadRunnable implements Runnable {
  static int mem;
  Thread T;

  ThreadRunnable(String name) {
    /* creation of a new Thread */
    T = new Thread(this);
    /* setting of the name */
    setName(name);
  }

  /* redefinition of the run() method */
  public void run() {
    for(int i=0; i<10; i++) {
      System.out.println(getName()+"("+i+") = "+(mem++));

      try {
        /* call of the sleep() method to sleep 0 to 100 msec */
        T.sleep((int)Math.random()*100);
      } catch(InterruptedException e) {
        System.out.println("Sleep interrupted !");
      }
    }
  }
  
  public void start() {
    T.start();
  }

  public String getName() {
    return(T.getName());
  }

  public void setName(String name) {
    T.setName(name);
  }

}


