
public class FiveRaceTest_P
 {
    private final static int NUMRUNNERS = 5 ;

    public static void main(String[] args)
       {
        SelfishRunner2[] runners = new SelfishRunner2[NUMRUNNERS];

        for (int i = 0; i < NUMRUNNERS; i++)
           {
            runners[i] = new SelfishRunner2(i);
            runners[i].setPriority(10-i);
           }
        for (int i = 0; i < NUMRUNNERS; i++)
            runners[i].start();
       }
 }

