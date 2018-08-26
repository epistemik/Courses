import java.util.Random;

class Semaphore
{
	private int count;

	public Semaphore(int count)
	{
		this.count = count;
	}

	synchronized public void Wait()
	{
		count--;
		if (count<0) {
			// then place this thread in waiting queue
			try{wait();} catch (Exception e) { }
		}
	}


	synchronized public void Signal()
	{
		count++;
		if (count<=0) {
			// then remove a thread in waiting queue
			// and place it in enter queue
			notify(); 
		}
	}

}//Semaphore


class DrawingStack
{
	private int buff_size;
	private int buffer[];
	private int nextin;
	
	private Semaphore synch_jury;

	public DrawingStack(int buff_size, Semaphore synch_jury)
	{
		this.buff_size = buff_size;
		nextin = 0;
		buffer = new int[buff_size];
		this.synch_jury = synch_jury; 
	}

	public void put_drawing(int artist_id)
	{
		if (nextin >= buff_size) {
			System.out.println("ERROR: BUFFER OVERFLOW");
		}
		buffer[nextin] = artist_id;
		System.out.println("Artist " + artist_id + 
			" has handed drawing #" + nextin);
		nextin++;
		if (nextin==buff_size) {
			synch_jury.Signal(); //jury may start his duty
		}
	}

	public int get_winner()
	{
		int index = (int) (buff_size*Math.random());
		return buffer[index];
	}

}//DrawingStack


class Jury extends Thread
{
	private DrawingStack drawingPile;
	private Semaphore synch_jury;
	private Artist artist[];
	private int numb_of_art;

	public Jury(DrawingStack drawingPile, Semaphore synch_jury, 
	            Artist artist[], int numb_of_art)
	{
		this.drawingPile = drawingPile;
		this.synch_jury = synch_jury;
		this.numb_of_art = numb_of_art;
		this.artist = artist;
	}

	public void run()
	{
		synch_jury.Wait(); //wait until all drawings are handed
		int winner = drawingPile.get_winner();
		System.out.println("AND THE WINNER IS ...  ARTIST " + winner); 
		
		//then stop all the artists (they should be all blocked)
		for (int i=0; i<numb_of_art; i++) {
			artist[i].stop();
		}

	
	}//run()

}//Jury


class Artist extends Thread
{
	private int id;
	
	private Semaphore synch_paper;
	private Semaphore mutex_drawing;
	private Semaphore red;
	private Semaphore blue;
	private Semaphore yellow;
	private Semaphore green;
	private Semaphore can_pick_pen;
	
	private DrawingStack drawingPile;
		
	public Artist(int id, DrawingStack drawingPile,
			Semaphore synch_paper, Semaphore mutex_drawing,
			Semaphore red, Semaphore blue, Semaphore yellow,
			Semaphore green, Semaphore can_pick_pen)
	{
		this.id = id;
		this.drawingPile = drawingPile;
		this.synch_paper = synch_paper;
		this.mutex_drawing = mutex_drawing;
		this.red = red;
		this.blue = blue;
		this.yellow = yellow;
		this.green = green;
		this.can_pick_pen = can_pick_pen;
	}

	public void run()
	{
	
	   while(true) {
		
		//this blocks the artist only when there are no more sheets available
		//decreases synch_paper.count by one
		synch_paper.Wait(); //the artist has taken a sheet of paper
		
		//blocks if 3 or more artist attempt to pick pencils
		can_pick_pen.Wait();
		
		//pick your pencils
		red.Wait();
		blue.Wait();
		yellow.Wait();
		green.Wait();
		
		System.out.println("Artist " + id + " makes a drawing");
		
		red.Signal();
		blue.Signal();
		yellow.Signal();
		green.Signal();
		
		can_pick_pen.Signal();
		
		//return the drawing: sleep for 1 to 8 msec
		int sleep_time = 1 + (int) (8*Math.random());
		try {sleep(sleep_time);} catch (Exception e) { };
		
		//place the drawing in drawing pile 
		mutex_drawing.Wait();
		drawingPile.put_drawing(id);
		mutex_drawing.Signal();
		
		//getting a new sheet of paper: sleep for 1 to 8 msec
		int sleep_time2 = 1 + (int) (8*Math.random());
		try {sleep(sleep_time2);} catch (Exception e) { };
		

	   }//while(true)	
		
	
	}//run()

}//Artist


public class Ass2
{

  public static void main(String args[])
  {
  
  	final int NUMB_OF_SHEETS = 100;
	final int NUMB_OF_ARTISTS = 5;
	
	//these semaphores are initialized to 3
	//since we have 3 pens of each color
	Semaphore red = new Semaphore(3);     
	Semaphore blue = new Semaphore(3);     
	Semaphore yellow = new Semaphore(3);     
	Semaphore green = new Semaphore(3); 

	//to block artists when no more sheets of paper is available
	Semaphore synch_paper = new Semaphore(NUMB_OF_SHEETS); 
	
	Semaphore mutex_drawing = new Semaphore(1); //mutex on handing drawing
	
	//used to unblock Jury when all drawings are done 
	Semaphore synch_jury = new Semaphore(0);  

	//we must allow at most 3 artists at a time that can try to pick 
	//pencils, otherwhise deadlock can occur
	Semaphore can_pick_pen = new Semaphore(3);   

	DrawingStack drawingPile = new DrawingStack(NUMB_OF_SHEETS, synch_jury);
		
	Artist artist[];
	artist = new Artist[NUMB_OF_ARTISTS];
	
	for (int i=0; i<NUMB_OF_ARTISTS; i++) {
		artist[i] = new Artist(i, drawingPile, synch_paper, mutex_drawing, 
		                       red, blue, yellow, green, can_pick_pen); 
	
	}
	
	Jury jury = new Jury(drawingPile, synch_jury, artist, NUMB_OF_ARTISTS);

	
	for (int i=0; i<NUMB_OF_ARTISTS; i++) {
		artist[i].start();
	}
	
	jury.start();
	
	

  }//main

}//Ass2
