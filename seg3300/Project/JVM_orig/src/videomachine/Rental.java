package videomachine;

/**
 * Title: Rental.java
 * Description: part of SEG3300 Project
 * Copyright: Mark Sattolo Copyright (c) 2001
 * Company: Applied Logic Technologies
 * @author Mark Sattolo
 * @version 1.0
 */

public class Rental extends Transaction
{
 private final static int MAXRENTALS = 4 ;
 private int startIndex = 0 ;
 private cassetteDB selected = null ;
 private int numSelections = 0 ;
 private String currentTitle ;
 private double currentCost = 0.0 ;
 private double totalCost = 0.0 ;

  public Rental(RemoteSystem r, Customer c)
   { super(r, c) ; }

  int newRental()
   {
    if (selected == null)
      {
       if (customer.getCurrentRentals() == null)
         selected = new cassetteDB(MAXRENTALS) ;
       else
          { selected = customer.getCurrentRentals() ;
            startIndex = selected.getSize() ; }
      }
    if (selected.getSize() >= MAXRENTALS)
      {
       System.out.println("\nYou already have the maximum number of rentals.");
       if (numSelections > 0)
         return payment();
       else
           return 3 ; //end session
      }
    return rentalChoice() ;
   }

  int rentalChoice()
   {
    int entry ;
    boolean num = false ;
    System.out.println("\n1.Search for a cassette");
    System.out.println("2.Proceed to check-out");
    System.out.println("3.Cancel rental and return to main menu");
    System.out.print("Please enter a cassette code or a transaction number: ");
    String userChoice = Machine.getInputString() ;
    try
       { entry = Integer.parseInt(userChoice) ;
         num = true ; }
    catch (Exception e)
       { return code(userChoice) ; }
    if (num)
      { if (entry == 2) return payment() ;
        if (entry == 3) return cancel() ;
        return search() ; }//if
    return 3 ;
   }

  int search()
   {
    int selection ;
    System.out.println("\nYou may search for a cassette title, or film principal actors or director.");
    System.out.print("Using the keyboard, please enter a term to search on: ") ;
    String searchTerm = Machine.getInputString() ;
    cassetteDB results = remote.search(searchTerm) ;
    if (results.getSize() == 0)
      {
       System.out.println("\nYour search did not return any results.") ;
       return rentalChoice() ;
      }
    if (results.getSize() == 1)
      {
       System.out.println("\nThere is only one item matching your search.") ;
       selection = 0 ; }//if
    else
      {
       System.out.println("\nYour search results are: ") ;
       for (int i=0,j=1; i<results.getSize(); i++,j++)
          System.out.println(j + "." + results.getCassetteByIndex(i).getTitle()) ;
       System.out.print("Please enter the number of your selection: ") ;
       selection = Machine.getInputInteger()-1 ;
       while (selection < 0 || selection >= results.getSize())
           {
            System.out.print("'" + (selection+1) + "'is not a valid entry.\nPlease enter the number of your selection: ") ;
            selection = Machine.getInputInteger()-1 ;
           }
      }//else
    addCassette(results.getCassetteByIndex(selection)) ;
    return confirmSelection() ;
   }

  void addCassette(Cassette cass)
   {
    if (cass != null)
      {
       selected.addCassette(cass) ;
       numSelections++ ;
       currentTitle = cass.getTitle() ;
       currentCost = cass.getCost() ;
       totalCost += currentCost ; }//if
   }

  int confirmSelection()
   {
    System.out.print("\nYour selection is cassette: " + currentTitle) ;
    System.out.println(" for $" + currentCost) ;
    System.out.println("1.Rent this cassette and proceed to check-out");
    System.out.println("2.Rent this cassette and choose another cassette");
    System.out.println("3.Cancel this cassette and choose another cassette");
    System.out.println("4.Cancel this cassette and proceed to check-out");
    System.out.println("5.Cancel rentals and return to main menu");
    System.out.print("Please enter the number of your selection: ") ;
    int selection = Machine.getInputInteger() ;
    switch (selection)
     {
      case 2: return newRental();
      case 5: return cancel();
      case 3: cancelCurrent(); return rentalChoice() ;
      case 4: cancelCurrent() ;
      default: return payment() ; }//switch
   }

  int payment()
   {
    int numSelected = selected.getSize() ;
    if (numSelected > 0)
      {
       System.out.println("\nYou have selected cassettes: ") ;
       for (int i=startIndex; i<numSelected; i++)
          System.out.println(selected.getCassetteByIndex(i).getTitle()) ;
       System.out.println("Total charges will be $" + totalCost);
       System.out.println("1.Pay from credit account  2.Pay by cash  3.Cancel rental");
       System.out.print("Please enter the number of your choice: ");
       int payMethod = Machine.getInputInteger();
       if (payMethod == 2) return payByCash();
       if (payMethod == 3) return cancel();
       return payByCredit();
      }//if
    else
       { System.out.println("\nYou have not yet selected any cassettes.") ;
         return search() ; }
   }

  int payByCredit()
   {
    if (totalCost > customer.getBalance())
      {
       System.out.print("\nYou do not have enough funds in your account to pay for your selection(s).") ;
       System.out.println("1.Pay by cash  2.Cancel rental and return to main menu");
       System.out.print("Please enter the number of your payment choice: ");
       int altChoice = Machine.getInputInteger();
       if (altChoice == 2)
         return cancel();
       else
           return payByCash();
      } //endif
    else
       { creditPayment cred = new creditPayment(remote, customer, selected, totalCost, startIndex) ;
         return cred.pay(); }
   }

  int payByCash()
   {
    cashPayment cash = new cashPayment(remote, customer, selected, totalCost, startIndex);
    return cash.pay();
   }

  void cancelCurrent()
   {
    numSelections-- ;
    totalCost -= currentCost ;
    selected.removeLast() ;
    Cassette seln = selected.getLast() ;
    if (seln != null)
      { currentCost = seln.getCost() ;
        currentTitle = seln.getTitle() ; }
    else
      { currentCost = 0.0 ;
        currentTitle = null ; }
   }

  int cancel()
   { return 2 ; }

  int code(String code)
   {
    Cassette codeMatch = remote.findCassByCode(code) ;
    if (codeMatch == null)
      {
       System.out.println("\nThat cassette is not currently available. Please make another choice.");
       return rentalChoice();
      }
    addCassette(codeMatch) ;
    return confirmSelection() ;
   }

} //class Rental