import javax.swing.JApplet;
import javax.swing.JPanel;
import java.awt.Graphics;
import java.awt.Color;
import java.awt.Container;

import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public class RaceApplet extends JApplet implements Runnable {

    private final static int NUMRUNNERS = 2;
    private final static int SPACING = 20;

    private Runner[] runners = new Runner[NUMRUNNERS];

    private Thread updateThread = null;

    public void init() {
        String raceType = getParameter("type");
        for (int i = 0; i < NUMRUNNERS; i++) {
            runners[i] = new Runner();
            if (raceType.compareTo("unfair") == 0)
                    runners[i].setPriority(i+2);
            else
                    runners[i].setPriority(2);
        }
        if (updateThread == null) {
            updateThread = new Thread(this, "Thread Race");
            updateThread.setPriority(NUMRUNNERS+2);
        }
        addMouseListener(new MyAdapter());
        setContentPane(new AppletContentPane());
    }

    class MyAdapter extends MouseAdapter {
        public void mouseClicked(MouseEvent evt) {
            if (!updateThread.isAlive())
                updateThread.start();
            for (int i = 0; i < NUMRUNNERS; i++) {
                if (!runners[i].isAlive())
                    runners[i].start();
            }
        }
    }

    public void run() {
	Thread myThread = Thread.currentThread();
        while (updateThread == myThread) {
            repaint();
            try {
                Thread.sleep(3);
            } catch (InterruptedException e) { }
        }
    }    

    public void stop() {
        for (int i = 0; i < NUMRUNNERS; i++) {
            if (runners[i].isAlive())
                runners[i] = null;
        }
        if (updateThread.isAlive())
            updateThread = null;
    }

    class AppletContentPane extends JPanel {
        public void paintComponent(Graphics g) {
            super.paintComponent(g);
            g.setColor(Color.white);
            g.fillRect(0, 0, getSize().width, getSize().height);
            g.setColor(Color.black);
            for (int i = 0; i < NUMRUNNERS; i++) {
                int pri = runners[i].getPriority();
                g.drawString(new Integer(pri).toString(), 0, (i+1)*SPACING);
            }
            for (int i = 0; i < NUMRUNNERS; i++) {
                g.drawLine(SPACING, (i+1)*SPACING, 
		           SPACING + (runners[i].tick)/23000, (i+1)*SPACING);
            }
        }
    }
}
