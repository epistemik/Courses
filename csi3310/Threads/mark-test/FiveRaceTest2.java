
public class FiveRaceTest2
 {
    private final static int NUMRUNNERS = 5 ;

    public static void main(String[] args)
       {
        SelfishRunner2[] runners = new SelfishRunner2[NUMRUNNERS];

        for (int i = 0; i < NUMRUNNERS; i++)
           {
            runners[i] = new SelfishRunner2(i);
            runners[i].setPriority(2);
           }
        for (int i = 0; i < NUMRUNNERS; i++)
            runners[i].start();
       }
 }

