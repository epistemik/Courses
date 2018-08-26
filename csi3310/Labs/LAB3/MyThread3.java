
public class MyThread3 extends Thread
 {
  MyThread3 t3 ;

  MyThread3(String name, int val) // constructor1 with name and priority only
    {
     this.setName(name) ;
     this.setPriority(val) ;
    }

  MyThread3(String name, MyThread3 t3, int val) // constructor2 with a MyThread3 parameter
    {
     this.t3 = t3 ;
     this.setName(name) ;
     this.setPriority(val) ;
    }

  public void run()
    {
     try
        {
         if (t3 != null) // wait for t3 if it has been set
             t3.join() ;
         for ( int i = 0; i < 121; i++ )
             System.out.println(this.toString() + " : loop #" + i) ;
        }
     catch (InterruptedException ie) { System.err.println("Error: " + ie) ; }
     catch (Exception e) { System.err.println("Error: " + e) ; }
    }// run()

 }// class MyThread3

