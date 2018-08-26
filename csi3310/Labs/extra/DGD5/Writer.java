public class Writer extends Thread {
  SemaphoreFile sem;
  
  // constructor
  Writer(String name, SemaphoreFile sem) {
    super(name);
    this.sem = sem;
  }


  // run(), writer's behavior
  public void run() {
    for(;;) {
      
      // ask for access
      System.out.println(sem.getState()+getName()+" ask for access");
      sem.waitWriter(getName());
      System.out.println(sem.getState()+getName()+" obtained access");
      
      // access obtained, simulation of writing
      System.out.println(sem.getState()+ getName()+" is working");
      try {
	        sleep((long)(Math.random()*50));
      } catch(InterruptedException e) {
	        System.out.println(getName()+" interrupted !");
        }

      // work finished, leave file
      System.out.println(sem.getState()+getName()+" leaves file");
      sem.signalWriter();
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


