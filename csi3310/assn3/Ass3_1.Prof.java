import java.util.Random;

class CarQueue {

	public CarQueue() { }

	synchronized public void cwait () 
	{
		try {wait();} catch(Exception e) { }
	}

	synchronized public void csignal()
	{
		notify();
	}

	synchronized public void csignalAll()
	{
		notifyAll();
	} 

}//CarQueue

class TunnelController {

	private int nb_car_in_tunnel;
	private int sb_car_in_tunnel;

	private String nb_light;
	private String sb_light;

	private CarQueue nb_queue;
	private CarQueue sb_queue;

	public TunnelController(String nb_light, String sb_light, CarQueue nb_queue, CarQueue sb_queue)
	{
		this.nb_light = nb_light;
		this.sb_light = sb_light;
		nb_car_in_tunnel = 0;
		sb_car_in_tunnel = 0; 
		this.nb_queue = nb_queue;
		this.sb_queue = sb_queue;
		display_lights();
	}

	synchronized private void display_lights()
	{
		System.out.println("NORTHBOUND light = " + nb_light 
			+ "  --  SOUTHBOUND light = " + sb_light);
	}

	synchronized public String northbound_arrival()
	{
		if (sb_car_in_tunnel==0) {//then enter the tunnel
			nb_car_in_tunnel++;
			if (nb_light=="RED") {
				nb_light = "GREEN";
				display_lights();
			}
		} else { //do not enter the tunnel			
			if (nb_light=="GREEN") {
				nb_light = "RED";
				display_lights();
			} 
		}
		return nb_light;
	}

	synchronized public void northbound_departure(int car_id)
	{
		nb_car_in_tunnel--;
		System.out.println("Northbound car " + car_id + " leaves the tunnel");		
		if (nb_car_in_tunnel==0) { //unblock cars in southbound queue
			sb_queue.csignalAll();
		}	
	}

	synchronized public String southbound_arrival()
	{
		if (nb_car_in_tunnel==0) {//then enter the tunnel
			sb_car_in_tunnel++;
			if (sb_light=="RED") {
				sb_light = "GREEN";
				display_lights();
			}
		} else { //do not enter the tunnel			
			if (sb_light=="GREEN") {
				sb_light = "RED";
				display_lights();
			} 
		}
		return sb_light;
	}

	synchronized public void southbound_departure(int car_id)
	{
		sb_car_in_tunnel--;
		System.out.println("Southbound car " + car_id + " leaves the tunnel");
		if (sb_car_in_tunnel==0) { //unblock cars in northbound queue
			nb_queue.csignalAll();
		}	
	
	}
	
}//TunnelController


class NorthboundCar extends Thread {

	private int car_id;
	private TunnelController tc;
	private CarQueue nb_queue;

	public NorthboundCar(int car_id, TunnelController tc, CarQueue nb_queue)
	{
		this.car_id = car_id;
		this.tc = tc;
		this.nb_queue = nb_queue;
	}

	public void run() {
	   while (true) {
		while (tc.northbound_arrival()=="RED") {//put car in queue
			nb_queue.cwait();
		}
		//here light must be "GREEN"
		System.out.println("Northbound car " + car_id + " enters the tunnel");
		try {sleep(1);} catch (Exception e) { }
		tc.northbound_departure(car_id);
		int sp = 1 + (int)(5*Math.random());
		try {sleep(sp);} catch (Exception e) { }
	  }//while(true)
	}//run
 
}//NorthboundCar


class SouthboundCar extends Thread {

	private int car_id;
	private TunnelController tc;
	private CarQueue sb_queue;

	public SouthboundCar(int car_id, TunnelController tc, CarQueue sb_queue)
	{
		this.car_id = car_id;
		this.tc = tc;
		this.sb_queue = sb_queue;
	}

	public void run() {
	   while (true) {
		while (tc.southbound_arrival()=="RED") {//put car in queue
			sb_queue.cwait();
		}
		//here light must be "GREEN"
		System.out.println("Southbound car " + car_id + " enters the tunnel");
		try {sleep(1);} catch (Exception e) { }
		tc.southbound_departure(car_id);
		int sp = 1 + (int)(5*Math.random());
		try {sleep(sp);} catch (Exception e) { }
	  }//while(true)
	}//run
 
}//SouthboundCar


public class Ass3_1 {

	public static void main(String args[]) 
	{
		final int NO_OF_NB_CARS = 6;
		final int NO_OF_SB_CARS = 3;

		CarQueue nb_queue = new CarQueue();
		CarQueue sb_queue = new CarQueue();

		TunnelController tc = new TunnelController("GREEN", "GREEN", nb_queue, sb_queue);

		NorthboundCar nb_car[] = new NorthboundCar[NO_OF_NB_CARS];
		for (int i=0; i<NO_OF_NB_CARS; i++) {
			nb_car[i] = new NorthboundCar(i, tc, nb_queue);
		}

		SouthboundCar sb_car[] = new SouthboundCar[NO_OF_SB_CARS];
		for (int i=0; i<NO_OF_SB_CARS; i++) {
			sb_car[i] = new SouthboundCar(i, tc, sb_queue);
		}

		for (int i=0; i<NO_OF_NB_CARS; i++) {
			nb_car[i].start(); 
		}

		for (int i=0; i<NO_OF_SB_CARS; i++) {
			sb_car[i].start(); 
		}

	}//main

}//Ass3

