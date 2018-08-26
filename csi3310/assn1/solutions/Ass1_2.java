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

class Owner extends Thread {
	private int oid; //owner identification
	private Account acc[];
	private int nacc;
	private int min_time = 10;
	private int max_time = 40;
	private int wp = 20;

	public Owner(int oid, Account acc[], int nacc) {
		this.oid = oid;
		this.acc = acc;
		this.nacc = nacc; //number of accounts
	}

	public void run() {

	   while (true) {

		int sa = (int) (nacc*Math.random()); //source account
		int da; //dest. account
		do {
			da = (int) (nacc*Math.random()); 
		} while (da==sa); //da and sa have to be different
		int bal = acc[sa].get_balance();
		if (bal>0) { //then you can try to transfer from source
			int amount = 1 + (int) (bal*Math.random());
			int ans = acc[sa].withdraw(amount);
			if (ans>0) { //withdraw operation accepted
				try {sleep(wp);} catch (Exception e) { }
				acc[da].deposit(amount);
				System.out.println("Owner has transferred $" + amount 
				+ " from account " + sa + " to account " + da);
			
			} else { //failure of withdraw operation
				//may happen if there are several owners
				System.out.println("FAILURE TO WITHDRAW MONEY--NO DEPOSIT");
				// do not make any deposit
			}
		} //otherwise do not try to transfer from source
		int sp = min_time + (int) ((max_time-min_time+1)*Math.random()); 
		try {sleep(sp);} catch (Exception e) { }
	
	   }	
			
	} //run
	

}


class CreditCardService extends Thread {

	private int threshold = 280;
	private Account acc[];
	private int nacc;
	private int ccid;
	private int min_time = 10;
	private int max_time = 40;	

	public CreditCardService(int ccid, Account acc[], int nacc) { 
		this.ccid = ccid;
		this.acc = acc;
		this.nacc = nacc;
	}

	public void run() {

	   while (true) {

		int sum = 0;
		for (int i=0; i<nacc; i++) {
			sum += acc[i].get_balance();
		}
		System.out.print("Total funds = $" + sum);
		if (sum >= threshold) { //accept to deliver card
			System.out.println(" -- accept to deliver card");
		} else { //refuse to deliver card
			System.out.println(" -- card refused!");
		}
		int sp = min_time + (int) ((max_time-min_time+1)*Math.random()); 
		try {sleep(sp);} catch (Exception e) { }

	   }
		
	} //run

}


class Ass1_2 {

	public static void main(String args[]) {

		int initial_amount = 100;
		int nacc = 3; //number of accounts

		Account acc[];
		acc = new Account[nacc];

		for(int i=0; i<nacc; i++) { 
		 	acc[i] = new Account(initial_amount);
		}

		Owner mario = new Owner(1, acc, nacc);
		CreditCardService MasterCard = new CreditCardService(1, acc, nacc);
		
		mario.start();
		MasterCard.start();

	} //main

}
