
public class SemaphoreFile2 {
  // number of readers and writers
  private int readers;
  private int writers;
  private int writersWaiting;
  

  // Constructor
  SemaphoreFile2() {
    readers = 0;
    writers = 0;
    writersWaiting = 0;
  }


  // taking of semaphore by a writer
  synchronized void waitWriter(String name) {
    while(readers != 0 || writers != 0) {
      try {
	        System.out.println(getState()+name+" is blocked");
	        writersWaiting++;
	        wait();
	        writersWaiting--;
	        System.out.println(getState()+name+" is released");
      } catch(InterruptedException e) {
	        System.out.println("waitWriter()/wait() interrupted !");
        }
    }
    writers++;
  }


  // release of semaphore by a writer
  synchronized void signalWriter() {
    writers--;
    notifyAll();
  }


  // taking of semaphore by a reader
  synchronized void waitReader(String name) {
    while(writers != 0) {
      try {
	        System.out.println(getState()+name+" is blocked");
	        wait();
	        System.out.println(getState()+name+" is released");
      } catch(InterruptedException e) {
	        System.out.println("waitWriter()/wait() interrupted !");
        }
    }
    readers++;
  }

  // release of semaphore by a reader
  synchronized void signalReader() {
    if(--readers == 0) {
      notifyAll();
    }
  }


  // method returning the state of the system in a string
  String getState() {
    return("* [W="+writers+"|R="+readers+"|WW="+writersWaiting+"] - ");
  }

}
