import java.awt.Graphics;
import java.awt.Color;
import java.util.*;
import java.text.DateFormat;

public class Clock extends java.applet.Applet implements Runnable {
    private Thread clockThread = null;

    public void init() {
        setBackground(Color.white);
    }
    public void start() {
        if (clockThread == null) {
            clockThread = new Thread(this, "Clock");
            clockThread.start();
        }
    }
    public void run() {
	Thread myThread = Thread.currentThread();
        while (clockThread == myThread) {
            repaint();
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e){ }
        }
    }
    public void paint(Graphics g) {
        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();
        DateFormat dateFormatter = DateFormat.getTimeInstance();
        g.drawString(dateFormatter.format(date), 5, 10);
    }
    public void stop() {
        clockThread = null;
    }
}
