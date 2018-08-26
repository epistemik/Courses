public class ReadersWriters {

  public static void main(String args[]) {
    
    // creation of semaphore
    SemaphoreFile sem = new SemaphoreFile();
    
    // creation of writers
    Writer w1 = new Writer("W1", sem);
    Writer w2 = new Writer("W2", sem);
    
    // creation of readers
    Reader r1 = new Reader("R1", sem);
    Reader r2 = new Reader("R2", sem);
    Reader r3 = new Reader("R3", sem);
    Reader r4 = new Reader("R3", sem);
    
    // start of readers and writers
    w1.start();
    w2.start();
    r1.start();
    r2.start();
    r3.start();
    r4.start();
  }
}
