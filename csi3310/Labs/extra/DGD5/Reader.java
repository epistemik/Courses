public class Reader extends Thread {
  SemaphoreFile sem;
  
  // constructor
  Reader(String name, SemaphoreFile sem) {
    super(name);
    this.sem = sem;
  }


  // run(), reader's behavior
  public void run() {
    for(;;) {
      
      // ask for access
      System.out.println(sem.getState()+getName()+" ask for access");
      sem.waitReader(getName());
      System.out.println(sem.getState()+getName()+" obtained access");
      
      // access obtained, simulation of reading
      System.out.println(sem.getState()+ getName()+" is working");
      try {
	        sleep((long)(Math.random()*50));
      } catch(InterruptedException e) {
          System.out.println(getName()+" interrupted !");
        }

      // work finished, leave file
      System.out.println(sem.getState()+getName()+" leaves file");
      sem.signalReader();
      System.out.println(sem.getState()+getName()+" has finished");

      // random wait and we loop !
      try {
	        sleep((long)(Math.random()*50));
      } catch(InterruptedException e) {
	        System.out.println(getName()+" interrupted !");
        }
    }
  }
}


