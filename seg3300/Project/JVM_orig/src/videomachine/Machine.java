package videomachine;

/**
 * Title: Machine.java
 * Description: part of SEG3300 Project
 * Copyright: Mark Sattolo Copyright (c) 2001
 * Company: Applied Logic Technologies
 * @author Mark Sattolo
 * @version 1.0
 */

public class Machine
{
 private static final double INITIALCASH = 1000.00 ;
 private static final int MAXINPUT = 255 ;
 private static final int MAXPINATTEMPTS = 5 ;
 private int ID ;
 private double cashOnHand ;
 private int pinAttempts = 0 ;
 private RemoteSystem myRemote ;
 private Customer currentCustomer ;

  public Machine(int i)
   {
    ID = i ;
    myRemote = new RemoteSystem( ID ) ;
    cashOnHand = INITIALCASH ;
   }

  static String getInputString()
   {
    byte response[] = new byte[MAXINPUT] ;
    String input ;
    try
      {
       System.in.read(response) ;
       input = new String(response) ;
      }
    catch( Exception e )
        {
         System.err.println( "Input error: " + e ) ;
         input = "ERROR" ;
        }
    return input.trim() ;
   }

  static int getInputInteger()
   {
    int entry ;
    String input = getInputString() ;
    try
      { entry = Integer.parseInt( input ) ; }
    catch( Exception e )
        {
         System.err.println( "\nInvalid input: using default value = 1 " ) ;
         entry = 1 ;
        }
    return entry ;
   }

/****************** MAIN *******************/
  public static void main(String[] args)
   {
    Machine m1 = new Machine(1) ;
    m1.startup() ;
   }

  public void startup()
   {
    String cardInfo = welcome() ;
    currentCustomer = myRemote.getCustomer( cardInfo ) ;
    if( currentCustomer == null )
      {
       System.out.println( "\nSorry, but we cannot validate this card." ) ;
       endSession() ;
      }
    else checkPIN() ;
   }

  String welcome()
   {
    System.out.println( "\nWelcome to 24-hour Video & Game. Please insert your card." ) ;
    System.out.print( " <Enter customer name on card>: " ) ;
    return getInputString() ;
   }

  void checkPIN()
   {
    int enteredPIN = getPIN() ;
    if( enteredPIN == currentCustomer.getPIN() )
      mainMenu() ;
    else
        badPIN() ;
   }

  int getPIN()
   {
    if( pinAttempts == 0 )
      System.out.print( "\nPlease enter your PIN using the keyboard: " ) ;
    else
        System.out.print( "Please try again to enter the PIN for this account using the keyboard: " ) ;
    return getInputInteger() ;
   }

  void badPIN()
   {
    System.out.println("\nSorry, but we cannot validate that PIN.") ;
    pinAttempts++ ;
    if( pinAttempts < MAXPINATTEMPTS )
      checkPIN() ;
    else
       {
        System.out.println("You have reached the maximum number of times to enter an invalid PIN.");
        endSession() ;
       }
   }

  void mainMenu()
   {
    System.out.println("\nMain Menu: 1.Rent a cassette      2.Browse account info");
    System.out.println("           3.Return a cassette    4.End session");
    System.out.print("Please choose a transaction number: ");
    int transactionType = getInputInteger() ;
    switch( transactionType )
      {
       case 2: browseAcct(); break ;
       case 3: returnCassette(); break ;
       case 4: endSession(); break ;
       default: rentCassette() ;
      } //switch
   }//mainMenu()

  void browseAcct()
   { System.out.println( "\nAccount balance is $" + currentCustomer.getBalance() );}

  void rentCassette()
   {
    Rental r = new Rental( myRemote, currentCustomer );
    int result = r.newRental() ;
    if( result == 2 )
      mainMenu() ;
    else if( result == 3 )
           endSession() ;
   }

  void returnCassette()
   { System.out.println( "\n [ Customer chooses to return a cassette ]\n" );}

  void endSession()
   { System.out.println( "Thank you for using 24-hour Video. Please take your card.\n" );}

} //class Machine