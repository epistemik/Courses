
public class SelfishRunner2 extends Thread
 {
    private int tick = 1;
    private int num;
    String[] names = {"Curly", "Larry", "Moe", "Fred", "Barney"} ;

    public SelfishRunner2(int num)
       {
        this.num = num;
       }

    public void run()
       {
        while (tick < 500000)
           {
            tick++;
            if ((tick % 50000) == 0)
                System.out.println(names[num] + ":\t tick = " + tick);
           }
       }
 }

