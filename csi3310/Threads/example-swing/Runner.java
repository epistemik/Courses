public class Runner extends Thread {
    public int tick = 1;
    public void run() {
        while (tick < 10000000)
            tick++;
    }
}
