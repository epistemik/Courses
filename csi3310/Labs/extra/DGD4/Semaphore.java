import java.io.*;
import java.lang.*;

class Semaphore {
  private boolean FREE;
  
  Semaphore() {
    FREE = true;
  }
  
  synchronized public void take() {
    while(!FREE) {
      try {
	        wait();
      } catch(InterruptedException e) {
	        System.out.println("Wait interrupted !");
        }      
    }
    FREE = false;
  }

  synchronized public void release() {
    FREE = true;
    notify();
  }

  public String state() {
    return(""+FREE);
  }

}

