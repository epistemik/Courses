import java.io.*;
import java.lang.*;


class Account {

	private int balance;

	public Account(int init_amount) {
		balance = init_amount;
	}

	public int get_balance() {
		return balance;
	}

	public int withdraw (int amount) {
		if (amount > balance) {
			return -1; //request rejected
		} else { 
			balance -= amount;
			return amount; //request accepted
		}
	}

	public void deposit (int amount) {
		balance += amount;
	}

}

class Provider extends Thread {
	private int pid; //provider identification
	private int bound = 100; // maximum amount that can be deposit
	private Account acc; 
	private int min_time = 10;
	private int max_time = 40;

	public Provider(int pid, Account acc) {
		this.pid = pid;
		this.acc = acc;	
	}

	public void run() {
		
	   while (true) {
		int rd = 1 + (int) (bound*Math.random()); // 1 <= rn <= bound
		acc.deposit(rd); 
		int bal = acc.get_balance(); 
		System.out.println("Provider " + pid + " made a deposit of $" + rd 
                            + " and the new balance is $" + bal); 
		int sp = min_time + (int) ((max_time-min_time+1)*Math.random()); 
		try {sleep(sp);} catch (Exception e) { }
	   }
	
	} //run

}


class Withdrawer extends Thread {
	private int wid; //withdrawer id
	private Account acc;
	private int min_time = 10;
	private int max_time = 40;
	private int wp = 20;

	public Withdrawer(int wid, Account acc) {
		this.wid = wid;
		this.acc = acc;	
	}


	public void run() {

	   while (true) {

		int bal = acc.get_balance();
		if (bal>0) { //then you can try to withdraw
			try {sleep(wp);} catch (Exception e) { }
			int amount = 1 + (int) (bal*Math.random());
			int ans = acc.withdraw(amount);
			bal = acc.get_balance(); //get balance again to display
			if (ans >= 1) { //withdraw request accepted
				System.out.println("Withdrawer " + wid + " has withdrawn $"
				+ amount + " and the new balance is $" + bal);
			} else { //withdraw request rejected
				System.out.println("Attempt to withdraw $" + amount  
				+ " by Withdrawer " + wid + " is rejected");
				System.out.println("Balance remains at $" + bal);
			}
		} //do not try to withdraw if bal was 0
		int sp = min_time + (int) ((max_time-min_time+1)*Math.random()); 
		try {sleep(sp);} catch (Exception e) { }

	   }

	} //run

} 


class Ass1_1 {

	public static void main(String args[]) {

		int initial_amount = 500;
		Account acc = new Account(initial_amount);

		Provider prov1 = new Provider(1, acc);
		Provider prov2 = new Provider(2, acc);
		Withdrawer with1 = new Withdrawer(1, acc);
		Withdrawer with2 = new Withdrawer(2, acc);

		prov1.start();
		prov2.start();
		with1.start();
		with2.start();

	} //main

}
