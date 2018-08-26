//  This application was developed using Inprise JBuilder 2.0 (JDK 1.1)

import java.io.*;
import java.util.*;
import java.text.*;

/**************************************************************************
 *
 *			  		Class OsbertApplication
 *
 **************************************************************************/
/*
/*		static final float TARGET_MARKUP
/*		static final float ANNUAL_INTEREST
/*
/*		public static void main ()
/*
/*------------------------------------------------------------------------*/

class OsbertApplication
{
	// constants
	static final float TARGET_MARKUP = (float) 2.15;
	static final float ANNUAL_INTEREST = (float) 1.085;

/*************************** MAIN ********************************/

	public static void main (String args[])
	//
	// Parameters:	args[] = arguments passed to the application from the
  // command line.  These are not required by this particular application,
  // but are required by the Java compiler.
	//
	{
    OsbertUtilities.displayMainMenu ();
  }
  // main

} // class OsbertApplication


/*************************************************************************
 *
 *		      		Class OsbertUtilities
 *
 *************************************************************************/
/*														*/
/*		public static void addArtist (String, String)				*/
/*		public static void clearScreen ()				*/
/*		public static void displayBuyPaintingMenu ()				*/
/*		public static void displayMainMenu ()				*/
/*		public static void displayReportMenu ()				*/
/*		public static boolean overTarget (String, String)			*/
/*		public static String removeDollarSign (String)				*/
/*		public static String removeQuestionMarks (String)			*/
/*														*/
/*------------------------------------------------------------------------*/

class OsbertUtilities
{

	public static void addArtist (String fn, String ln)
	//
	// addArtist inserts an artist name into the artist file.

	// Parameters:	fn = first name of artist to be added
	//				ln = last name of artist to be added
	//
	{
		try
		{
			File artistFile = new File ("artist.dat");
			File tempArtistFile = new File ("artist.tmp");

			if (!artistFile.exists ())
			{
				FileOutputStream newFileOutput = new FileOutputStream (artistFile);
				PrintWriter newFilePrint = new PrintWriter (newFileOutput);
				newFilePrint.println (fn + "|" + ln);
				return;
			}

			// stream object used for file input
			RandomAccessFile inFile = new RandomAccessFile (artistFile, "r");

			//stream object used for file output
			RandomAccessFile outFile = new RandomAccessFile (tempArtistFile, "rw");

			int				tempChar;	// temporary storage for reading in characters
			StringBuffer	tempFN;	// temporary string used for file copying
			StringBuffer	tempLN;	// temporary string used for file copying
			boolean			found;		// indicates if artist insertion point is found

			found = false;

			//
			// the following loop copies the current artist file to a temporary file
			//
			while (inFile.getFilePointer () != inFile.length ())
			{
				//
				// read a temporary first name from the artist file
				//
				tempFN = new StringBuffer ("");
				while ((tempChar = inFile.read ()) != '|')
				{
					tempFN.append ((char) tempChar);
				}

				//
				// read a temporary last name from the artist file
				//
				tempLN = new StringBuffer ("");
				while ((tempChar = inFile.read ()) != '\n')
				{
					tempLN.append ((char) tempChar);
				}

				int compareLastNames =
               OsbertUtilities.removeQuestionMarks(tempLN.toString ())
                        .compareTo(OsbertUtilities.removeQuestionMarks (ln));

				if ((compareLastNames < 0) || found)
				{
					outFile.writeBytes (tempFN.toString () + "|" + tempLN.toString () + "\n");
				}
				else if (compareLastNames > 0)
				{
					outFile.writeBytes (fn + "|" + ln + "\n");
					outFile.writeBytes (tempFN.toString () + "|" + tempLN.toString () + "\n");
					found = true;
				}
				else
				{
					if (OsbertUtilities.removeQuestionMarks (tempFN.toString ()).
							compareTo (OsbertUtilities.removeQuestionMarks (fn)) < 0)
					{
					 outFile.writeBytes (tempFN.toString () + "|" + tempLN.toString () + "\n");
					}
					else if (OsbertUtilities.removeQuestionMarks (tempFN.toString ()).compareTo
							(OsbertUtilities.removeQuestionMarks (fn)) > 0)
					{
						outFile.writeBytes (fn + "|" + ln + "\n");
						outFile.writeBytes (tempFN.toString () + "|" + tempLN.toString () + "\n");
						found = true;
					}
					else
					{
						outFile.writeBytes (fn + "|" + ln + "\n");
						found = true;
					}
				}
			} // while (inFile.getFilePointer () != inFile.length ())

			if (!found)
			{
				outFile.writeBytes (fn + "|" + ln + "\n");
			}

			inFile.close ();
			outFile.close ();

			artistFile.delete ();
			tempArtistFile.renameTo (artistFile);
     }
		catch (Exception e)
		{
			System.out.println ("***** Error: OsbertUtilities.addArtist () *****");
			System.out.println ("\t" + e);
		}

	} // addArtist


	public static boolean overTarget (String fn, String ln)
	//
	// overTarget examines all the sold paintings and determines if the artist represented
	// by the string parameters fn and ln (first name/last name) has had all of his or her
	// paintings sold over the target price during the past year (with at least 2 sales).
	// Returns true if all paintings were sold over the target price, otherwise false.
	//
	// Parameters:	fn = first name of artist under examination
	//				   ln = last name of artist under examination
	//
	{
		try
		{
			File	soldFile = new File ("sold.dat");
			OsbertDate	oneLess = new OsbertDate ();	// date one year ago today
			int  count;			// # of paintings sold over target price
			boolean found;				// indicates whether all paintings sold over target
			GalleryClass tempGallery = new GalleryClass ();	// temporary object used for file reading

			count = 0;
			found = true;

			oneLess.setYear (oneLess.getYear () - 1);

			if (soldFile.exists ())
			{

				RandomAccessFile inFile = new RandomAccessFile (soldFile, "r");

				//
				// examine all of the paintings that have been sold
				//
				while (inFile.getFilePointer () != inFile.length ())
				{
					//
					// read a temporary gallery object from the sold file
					//
					tempGallery.readSold (inFile);

					//
					// ensure that the temporary gallery object is the desired artist
					// and that the sale happened within the past year
					//
					if ((oneLess.compareTo (tempGallery.getSaleDate ()) <= 0) && (OsbertUtilities.							removeQuestionMarks (fn).compareTo (OsbertUtilities.
							removeQuestionMarks (tempGallery.getFirstName ())) == 0) &&
							(OsbertUtilities.removeQuestionMarks (ln).compareTo(OsbertUtilities.
							removeQuestionMarks (tempGallery.getLastName ())) == 0))

					{
						if (tempGallery.getSellPrice () > tempGallery.getTargetPrice ())
						{
							count++;
						}
						else
						{
							found = false;
						}
					}
				} // while (inFile.getFilePointer () != inFile.length ())

				inFile.close ();
			} // if (soldFile.exists ())

			//
			// return true iff all paintings sold in the past year were over the target
			// price (found == true) and there were at least 2 sales (count > 1)
			//
			if (found && (count > 1))
				return true;

			return false;
     }
		catch (Exception e)
		{
			System.out.println ("***** Error: OsbertUtilities.overTarget () *****");
			System.out.println ("\t" + e);
			return false;
		}

	} // overTarget


  public static char getChar()
  //
  // getChar returns the first character entered from the keyboard
  //
  {
    char ch = '\n';				// represents character read from the keyboard

    try
    {
      Reader in = new InputStreamReader(System.in);
      ch = (char)in.read();
    }
    catch (Exception e)
    {
      System.out.println("Error: " + e.toString());
    }

    return ch;

  } // getChar

  public static void pressEnter()
  //
  // pressEnter waits until the user presses the <ENTER> key
  //
  {

	  char ch = '\n';				// dummy variable used to induce keyboard input

    Reader in = new InputStreamReader(System.in);
    try
    {
      while ((ch=(char)in.read()) != '\n');
    }
    catch (Exception e)
    {
      System.out.println("Error: " + e.toString());
    }

  } // pressEnter

	public static void clearScreen ()
	//
	// clearScreen clears the screen
	//
	{
		int i; // loop counter representing the number of blank lines to be printed

		//
		// implementation-dependent code to clear the screen should replace the code
		// given below.
		//

		for (i = 0; i < 26; i++)
		{
			System.out.println ();
		}

	} // clearScreen


	public static void displayMainMenu ()
	//
	// displayMainMenu displays the main menu containing all the options available to the user.
	//
	{
		boolean				done;			// terminates while loop
		byte					choice[] = new byte[10];	// user's choice
		GalleryClass			painting = new GalleryClass ();	// painting object to be sold

		done = false;

		while (!done)
		{
			OsbertUtilities.clearScreen ();

			System.out.println ("\t               MAIN MENU\n\n");
			System.out.println ("\t         Osbert Oglesby - Collector of fine Art\n\n");
			System.out.println ("\t            1. Buy a painting\n");
			System.out.println ("\t            2. Sell a painting\n");
			System.out.println ("\t            3. Produce a report\n");
			System.out.println ("\t            4. Quit\n\n");
			System.out.print("\t         Enter your choice and press <ENTER>: ");

			try
			{
				System.in.read (choice);

				switch ((char) choice[0])
				{
					case '1':
						OsbertUtilities.displayBuyPaintingMenu ();
						break;

					case '2':
						painting.sell ();
						break;

					case '3':
						OsbertUtilities.displayReportMenu ();
						break;

					case '4':
						done = true;
						break;

					default:
						System.out.println ("\n\nChoice is out of range\n");
						System.out.println ("      Press <ENTER> to return to menu...");
                 OsbertUtilities.pressEnter();
						break;
				}
			}
			catch (Exception e)
			{
				System.out.println ("***** Error: OsbertUtilities.displayMainMenu () *****");
				System.out.println ("\t" + e);
			}
		}

	} // displayMainMenu

	public static void displayBuyPaintingMenu ()
	//
	// displayBuyPaintingMenu allows the user to select the type of painting to be purchased.
	//
	{
		boolean done;				// terminates while loop
  	char    choice;		// user's choice
		MasterpieceClass masterpiece = new MasterpieceClass (); // item to be bought
		MasterworkClass  masterwork = new MasterworkClass ();	// item to be bought
		OtherClass other = new OtherClass ();		// item to be bought
		FashionabilityClass fash = new FashionabilityClass ();	// item to be updated

		done = false;

		while (!done)
		{
			OsbertUtilities.clearScreen ();

			System.out.println ("\t            BUY PAINTING MENU\n\n");
			System.out.println ("\t      Osbert Oglesby - Collector of Fine Art\n\n");
			System.out.println ("\t        1. Buy a Masterpiece\n");
			System.out.println ("\t        2. Buy a Masterwork\n");
			System.out.println ("\t        3. Buy an Other piece of work\n");
			System.out.println ("\t        4. Update Fashionability Coefficient\n");
			System.out.println ("\t        5. Return to Main Menu\n\n");
			System.out.print ("\t      Enter your choice and press <ENTER>: ");

	 		try
			{
				choice = getChar();

				switch (choice)
				{
					case '1':
						masterpiece.buy ();
						break;

					case '2':
						masterwork.buy ();
						break;

					case '3':
						other.buy ();
						break;

					case '4':
						fash.addNewFash ();
						break;

					case '5':
						done = true;
						break;

					default:
						System.out.println ("\n\nChoice is out of range\n");
						System.out.println ("      Press <ENTER> to return to menu...");
                 choice = getChar();
						break;
				}
	   	}
			catch (Exception e)
			{
					System.out.println ("***** Error: OsbertUtilities.displayBuyPaintingMenu () *****");
					System.out.println ("\t" + e);
			}
		}

	} // displayBuyPaintingMenu

	public static void displayReportMenu ()
	//
	// displayReportMenu allows the user to select the type of report to be displayed
	//
	{
		boolean done;					// terminates while loop
		byte choice[] = new byte[10];	// user's choice
		GalleryClass painting = new GalleryClass ();	// item used to invoke report

		done = false;

		while (!done)
		{
			OsbertUtilities.clearScreen ();

			System.out.println ("\t            REPORT MENU\n\n");
			System.out.println ("\t      Osbert Oglesby - Collector of Fine Art\n\n");
			System.out.println ("\t        1. Report on Bought Paintings\n");
			System.out.println ("\t        2. Report on Sold Paintings\n");
			System.out.println ("\t        3. Report on Fashion Trends\n");
			System.out.println ("\t        4. Return to Main Menu\n\n");
			System.out.print ("\t      Enter your choice and press <ENTER>: ");

			try
			{
				System.in.read (choice);

				switch ((char) choice[0])
				{
					case '1':
						painting.boughtReport ();
						break;

					case '2':
						painting.sellReport ();
						break;

					case '3':
						painting.fashionReport ();
						break;

					case '4':
						done = true;
						break;

					default:
						System.out.println ("\n\nChoice is out of range\n");
						System.out.println ("      Press <ENTER> to return to menu...");
                 OsbertUtilities.pressEnter();
						break;
				}
			}
			catch (Exception e)
			{
				System.out.println ("***** Error: GalleryClass.displayReportMenu () *****");
				System.out.println ("\t" + e);
			}
		}

	} // displayReportMenu


	public static String removeQuestionMarks (String s)
	//
	// removeQuestionMarks returns a string equal to s but without any question marks
	//
	// Parameter:	s = string which may contain question marks
	//
	{
		StringBuffer oldString = new StringBuffer (s);	// string with ?
		StringBuffer newString = new StringBuffer ("");	// string without ?
		int  i;		// iterates over the length of StringBuffer oldString
		char c;		// character to append from oldString

		for (i = 0; i < oldString.length (); i++)
		{
			//
			// copy only the non-question mark characters
			//
			if ((c = oldString.charAt (i)) != '?')
			{
				newString.append (c);
			}
		}
     return newString.toString ();
  } // removeQuestionMarks


  public static String readString()
  //
  // this method will return a string entered from the keyboard
  //
  {
    StringBuffer tempBuffer = new StringBuffer();
    StringBuffer sb = new StringBuffer();
    String tempString;
    char c;
    int i;

    try
    {
      while ((c = (char)System.in.read( )) != '\n')
      {
        tempBuffer.append(c);
      }
    }
    catch(Exception e)
    {
      System.out.println("Exception: " + e.getMessage( ) + "has                                                                       occurred");
    }

/*    return  tempBuffer.toString();  */

    // The following code is needed when using JBuilder in order to
    // remove a trailing space. It replaces the return statement
    // given above.
    tempString = tempBuffer.toString();
    for (i=0; i<tempString.length() - 1; i++)
      sb.append(tempString.charAt(i));

    return sb.toString();

  }

	public static String removeDollarSign (String s)
	//
	// removeDollarSign returns a string equal to sbut without any dollar signs
	//
	// Parameter:	s = string which may contain dollar signs
	//
	{
		StringBuffer			oldString = new StringBuffer (s);	// string with $
		StringBuffer			newString = new StringBuffer ("");	// string without $
		int					i;		// iterates over the length of StringBuffer oldString
		char					c;		// character to append from oldString

		for (i = 0; i < oldString.length (); i++)
		{
			//
			// copy only the non-question mark characters
			//
			if ((c = oldString.charAt (i)) != '$')
			{
				newString.append (c);
			}
		}

		return newString.toString ();

	} // removeDollarSign

} // class OsbertUtilities


/****************************************************************************
 *
 *					Class OsbertDate
 *
 ****************************************************************************/
/*														*/
/*		private int date;								*/
/*		private int month;							*/
/*		private int year;								*/
/*		private boolean questionable;				*/
/*														*/
/*		private final static String monthString[]				*/
/*														*/
/*		OsbertDate ()									*/
/*		OsbertDate (int, int, int, boolean)				*/
/*		OsbertDate (OsbertDate)						*/
/*		OsbertDate (String)							*/
/*														*/
/*		public int getDate ()							*/
/*		public int getMonth ()							*/
/*		public int getYear ()							*/
/*														*/
/*		public boolean getQuestionable ()				*/
/*														*/
/*		public void setDate (int)						*/
/*		public void setMonth (int)					*/
/*		public void setYear (int)						*/
/*		public void setQuestionable (boolean)				*/
/*														*/
/*		public String toString ()						*/
/*		public int compareTo (OsbertDate))				*/
/*														*/
/*-------------------------------------------------------------------------*/

class OsbertDate
{

	private int	date;			// day of the month  [1,31]
	private int	month;		// month of the year [1,12]
	private int	year;			// year  [00,99]

	private boolean questionable;		// Is the date questionable?

	private final static String  monthString[] =
			{
				"January", "February", "March", "April", "May", "June", "July", "August",
				"September", "October", "November", "December"
			};

	//
	// constructors
	//
	public OsbertDate ()
	{
	   Date today = new Date ();
     Calendar c = new GregorianCalendar();

     c.setTime(today);

		date = c.get(Calendar.DAY_OF_MONTH);
		month = c.get(Calendar.MONTH) + 1;
		year = c.get(Calendar.YEAR) - 1900;

		questionable = false;
	} // OsbertDate ()

	public OsbertDate (int newDate, int newMonth, int newYear, boolean question)
	{
		date = newDate;
		month = newMonth;
		year = newYear;

		questionable = question;

	} // OsbertDate (int, int, int, boolean)

	public OsbertDate (OsbertDate newOsbertDate)
	{
		this (newOsbertDate.getDate (), newOsbertDate.getMonth (), newOsbertDate.getYear (),
				newOsbertDate.getQuestionable ());

	} // OsbertDate (OsbertDate)

	public OsbertDate (String newDate)
	//
	// Accepts a string mm/dd/yy?
	//
	{
    Date tempDate;
    SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
    Calendar c = new GregorianCalendar();

    questionable = newDate.charAt (newDate.length () - 1) == '?';

    try
    {
       tempDate = dateFormat.parse(OsbertUtilities.removeQuestionMarks(newDate));

       c.setTime(tempDate);
       date= c.get(Calendar.DAY_OF_MONTH);
       month = c.get(Calendar.MONTH) + 1;
       year = c.get(Calendar.YEAR) - 1900;

    }
    catch (ParseException pe)
    {
  	  System.out.println("\n\tError: Date format incorrect...\n");
    }

	} // OsbertDate (String)

	//
	// accessor functions
	//
 	public int getDate ()					{ return date; }
	public int getMonth ()					{ return month; }
	public int getYear ()					{ return year; }
	public boolean getQuestionable ()	{ return questionable; }

	public boolean setDate (int newDate)
	{
	//
	// setDate changes the date member
	//
	// Returns true if date is in range, otherwise false
	//

		if ((newDate > 0) && (newDate <= 31))
		{
			date = newDate;
			return true;
		}
		else
			return false;

	} // setDate

	public boolean setMonth (int newMonth)
	{
	//
	// setMonth changes the month member
	//
	// Returns true if month is in range, otherwise false

		if ((newMonth > 0) && (newMonth <= 12))
		{
			month = newMonth;
			return true;
		}
		else
			return false;

	} // setMonth

	public boolean setYear (int newYear)
	//
	// setYear changes the year member
	//
	// Returns true if year is in range [00, 99], otherwise false
	//
	{
		if ((newYear >= 0) && (newYear <= 99))
		{
			year = newYear;
			return true;
		}
		else
			return false;

	} // setYear

	public void setQuestionable (boolean question)
	{
	//
	// setQuestionable changes the questionable member
	//
 		questionable = question;
 	} // setQuestionable


	//
	// new or overridden methods
	//

	public String toString ()
	{
	//
	// toString returns the OsbertDate as a string in the form "mm/dd/yy"

 		String					returnValue = new String ();
		String					theMonth = new String ();
		String					theDate = new String ();
		String					theYear = new String ();

		if (month < 10)
			theMonth = "0" + String.valueOf (month);
		else
			theMonth = String.valueOf (month);

		if (date < 10)
			theDate = "0" + String.valueOf (date);
		else
			theDate = String.valueOf (date);

		if (year < 10)
			theYear = "0" + String.valueOf (year);
		else
			theYear = String.valueOf (year);

		if (questionable)
			returnValue = theMonth + "/" + theDate + "/" + theYear + "?";
		else
			returnValue = theMonth + "/" + theDate + "/" + theYear;
		return returnValue;

	} // toString

	public int compareTo (OsbertDate otherDate)
	{
	//
	// compareTo compares two OsbertDates
	//
	// Returns:	-1 if this comes before otherDate,
	//			0 if the two OsbertDates are the same,
	//			1 if this comes after otherDate
	//

		if (year < otherDate.getYear ())
			return -1;
		else if (year > otherDate.getYear ())
			return 1;
		else
		{
			if (month < otherDate.getMonth ())
				return -1;
			else if (month > otherDate.getMonth ())
				return 1;
			else
			{
				if (date < otherDate.getDate ())
					return -1;
				else if (date > otherDate.getDate ())
					return 1;
				else
					return 0;
			}
		}

	} // compareTo (OsbertDate)

} // class OsbertDate

/**************************************************************************
 *
 *				  	Class PaintingClass
 *
 **************************************************************************/
/*														*/
/*		protected String firstName;					*/
/*		protected String lastName;					*/
/*		protected String title;							*/
/*		protected String paintingDate;				*/
/*		protected String medium;					*/
/*		protected String subject;						*/
/*		protected float height;						*/
/*		protected float width;						*/
/*														*/
/*		PaintingClass ()								*/
/*														*/
/*		public String getFirstName ()					*/
/*		public String getLastName ()					*/
/*		public String getTitle ()						*/
/*		public String getPaintingDate ()				*/
/*		public String getMedium ()					*/
/*		public String getSubject ()					*/
/*		public float getHeight ()						*/
/*		public float getWidth ()						*/
/*														*/
/*		public void getDescription ()					*/
/*														*/
/*-----------------------------------------------------------------------*/

class PaintingClass
{
  // constructor
	public PaintingClass ()				{ }
  //
	// class data members
	//
	protected String			firstName;	// first name of artist
	protected String			lastName;	// last name of artist
	protected String			title;		// title of painting
	protected String			paintingDate;	// year painting was created
	protected String			medium;	// medium of painting
	protected String			subject;	// subject of painting
	protected float			height;	// height of painting (in cm)
	protected float			width;		// width of painting (in cm)

	//
	// data member access functions
	//
	public String getFirstName ()			{ return firstName; }
	public String getLastName ()			{ return lastName; }
	public String getTitle ()				{ return title; }
	public String getPaintingDate ()		{ return paintingDate; }
	public String getMedium ()			   { return medium; }
	public String getSubject ()			{ return subject; }
	public float getHeight ()				{ return height; }
	public float getWidth ()				{ return width; }

	//
	// class member function
	//
	public void getDescription ()
	//
	// getDescription retrieves painting description information.
	//
	{
     try
		{
			StringBuffer		input;
			char				c;
			boolean			valid;

			OsbertUtilities.clearScreen ();

			System.out.println ("Please enter the following information about the painting:\n");

			System.out.println ("Note: Do not leave any request blank.\n\n");

			System.out.println ();
			System.out.println ();

			System.out.print ("Enter the FIRST name of the artist (append ? if uncertain): ");
			firstName = OsbertUtilities.readString();

			System.out.print ("Enter the LAST name of the artist (append ? if uncertain): ");
			lastName = OsbertUtilities.readString();

			System.out.print ("Enter the TITLE of the painting (append ? if uncertain): ");
			title = OsbertUtilities.readString();

			System.out.print ("Enter the DATE the painting was created (yyyy): ");
			paintingDate = OsbertUtilities.readString();

			System.out.print ("Enter the HEIGHT of the painting (in centimeters): ");
			Float tempFloat = new Float (OsbertUtilities.readString());
			height = tempFloat.floatValue ();

			System.out.print ("Enter the WIDTH of the painting (in centimeters): ");
			tempFloat = new Float (OsbertUtilities.readString());
			width = tempFloat.floatValue ();

			//
			// retrieves and validates a value for medium
			//
			valid = false;
			while (!valid)
			{
				System.out.print ("Enter the MEDIUM of the painting (oil, watercolor, other): ");
				medium = OsbertUtilities.readString();
				medium.toLowerCase ();

				if ((medium.compareTo ("oil") == 0) || (medium.compareTo ("watercolor") == 0) ||
					(medium.compareTo ("other") == 0))

				{
					valid = true;
				}
				else
				{
					System.out.println ("\nInvalid response!");
					System.out.println ("Please enter one of the following: oil, watercolor, other\n");
				}
			}

			//
			// retrieves and validates a value for subject
			//
			valid = false;
			while (!valid)
			{
				System.out.print ("Enter the SUBJECT of the painting");
				System.out.print (" (portrait, landscape, still-life, other): ");
				subject = OsbertUtilities.readString();
				subject.toLowerCase ();

				if ((subject.compareTo ("portrait") == 0) || (subject.compareTo ("landscape") == 0) ||
					(subject.compareTo ("still-life") == 0) || (subject.compareTo ("other") == 0))
				{
					valid = true;
				}
				else
				{
					System.out.println ("\nInvalid response!");
					System.out.print ("Please enter one of the following: ");
					System.out.println (" portrait, landscape, still-life, other\n");
				}
			}
     }
		catch (Exception e)
		{
			System.out.println ("***** Error: PaintingClass.getDescription () *****");
			System.out.println ("\t" + e);
		}

	} // getDescription

} // class PaintingClass

/***************************************************************************
 *
 *					Class GalleryClass
 *
 **************************************************************************/
/*														*/
/*		protected String classification;				*/
/*		protected OsbertDate purchaseDate;				*/
/*		protected OsbertDate saleDate;				*/
/*		protected String sellerName;					*/
/*		protected String buyerName;					*/
/*		protected String sellerAddress;				*/
/*		protected String buyerAddress;				*/
/*		protected float algorithmPrice;				*/
/*		protected float purchasePrice;				*/
/*		protected float targetPrice;					*/
/*		protected float sellPrice;					*/
/*														*/
/*		public GalleryClass ()							*/
/*														*/
/*		public float getAlgorithmPrice ()				*/
/*		public String getBuyerAddress ()				*/
/*		public String getBuyerName ()				*/
/*		public String getClassification ()				*/
/*		public OsbertDate getPurchaseDate ()				*/
/*		public OsbertDate getSaleDate ()				*/
/*		public String getSellerAddress ()				*/
/*		public String getSellerName ()					*/
/*		public float getPurchasePrice ()				*/
/*		public float getSellPrice ()					*/
/*		public float getTargetPrice ()					*/
/*														*/
/*		public void addNewPainting ()				*/
/*		public void addNewSale ()					*/
/*		public void boughtReport ()					*/
/*		public void buy ()								*/
/*		protected void determineAlgorithmPrice ()				*/
/*		public void fashionReport ()					*/
/*		public void getGalleryInformation ()				*/
/*		public void readBought (RandomAccessFile)				*/
/*		public void readSold (RandomAccessFile)				*/
/*		public void sell ()								*/
/*		public void sellReport ()						*/
/*		public void writeBought (RandomAccessFile)				*/
/*		public void writeSold (RandomAccessFile)				*/
/*														*/
/*-----------------------------------------------------------------------*/


class GalleryClass extends PaintingClass
{
	public GalleryClass ()					{ }
	//
	// class data members
	//
	protected String classification;		// gallery classification type
	protected OsbertDate purchaseDate;	// date painting was purchased
	protected OsbertDate saleDate;		// date painting was sold
	protected String sellerName;			// full name of seller
	protected String buyerName;			// full name of painting buyer
	protected String sellerAddress;		// address of seller
	protected String buyerAddress;		// address of buyer
	protected float algorithmPrice;		// price determined by algorithm
	protected float purchasePrice;		// actual purchase price
	protected float targetPrice;			// target selling price
	protected float sellPrice;			   // actual selling price
	//
	// data member access functions
	//
	public String getClassification ()		{ return classification; }
	public OsbertDate getPurchaseDate ()	{ return purchaseDate; }
	public OsbertDate getSaleDate ()		   { return saleDate; }
	public String getSellerName ()			{ return sellerName; }
	public String getBuyerName ()		      { return buyerName; }
	public String getSellerAddress ()		{ return sellerAddress; }
	public String getBuyerAddress ()		   { return buyerAddress; }
	public float getAlgorithmPrice ()		{ return algorithmPrice; }
	public float getPurchasePrice ()		   { return purchasePrice; }
	public float getTargetPrice ()			{ return targetPrice; }
	public float getSellPrice ()			   { return sellPrice; }

	//
	// class member functions
	//

	public void getGalleryInformation ()
	//
	// getGalleryInformation retrieves gallery painting information
	//
	{
		try
		{
			StringBuffer		input;
			char				c;

			System.out.println ();
			System.out.println ();

			purchaseDate = new OsbertDate ();

			System.out.print ("Enter the NAME of the seller: ");
			sellerName = OsbertUtilities.readString();

			System.out.print ("Enter the ADDRESS of the seller: ");
			sellerAddress = OsbertUtilities.readString();

			System.out.print ("Enter the purchase PRICE of the painting: ");
			Float tempFloat = new Float (OsbertUtilities.removeDollarSign (OsbertUtilities.readString()));
			purchasePrice = tempFloat.floatValue ();

			targetPrice = purchasePrice * OsbertApplication.TARGET_MARKUP;

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: GalleryClass.getGalleryInformation () *****");
			System.out.println ("\t" + e);
		}

	} // getGalleryInformation

	public void addNewPainting ()
	//
	// addNewPainting inserts a gallery object in the proper place
	//
	{
		try
		{
			File galleryFile = new File ("gallery.dat");
			File tempGalleryFile = new File ("gallery.tmp");

			if (!galleryFile.exists ())
			{
				RandomAccessFile newFile = new RandomAccessFile (galleryFile, "rw");
				writeBought (newFile);
				newFile.close ();
				return;
			}

			// stream object used for file input
			RandomAccessFile inFile = new RandomAccessFile (galleryFile, "r");

			// stream object used for file output
			RandomAccessFile outFile = new RandomAccessFile (tempGalleryFile, "rw");
			boolean			found;		// indicates if object insertion point found
			GalleryClass		tempGallery = new GalleryClass ();															// temporary object used for file copying

			found = false;

			while (inFile.getFilePointer () != inFile.length ())
			{
				//
				// read a temporary gallery object from the temporary file
				//
				tempGallery.readBought (inFile);

				//
				// write the proper object to the gallery file
				//
				if ((tempGallery.classification.compareTo (classification) <= 0) &&
					(tempGallery.purchaseDate.compareTo (purchaseDate) <= 0) &&
					!found)

				{
					//
					// write the galleryÊobject to the gallery file
					//
					writeBought (outFile);

					//
					// write the temporary gallery object to the gallery file
					//
					tempGallery.writeBought (outFile);

					found = true;
				}
				else
				{
					tempGallery.writeBought (outFile);
				}
			} // while (!inFile.eof ())

			//
			// write the gallery object to the end of the gallery file
			//
			if (!found)
			{
				writeBought (outFile);
			}

			inFile.close ();
			outFile.close ();

			galleryFile.delete ();
			tempGalleryFile.renameTo (galleryFile);

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: GalleryClass.addNewPainting () *****");
			System.out.println ("\t" + e);
		}

	} // addNewPainting

	public void buy ()
	//
	// buy allows user to buy a painting
	//
	{
		try
		{
			File galleryFile = new File ("gallery.dat");
			byte ch[] = new byte[3];			// holds user response to Y/N question
			boolean found;					// indicates if painting already in gallery
			GalleryClass tempGallery = new GalleryClass ();	// temporary object used for file reading

			getDescription ();

			found = false;

			if (galleryFile.exists ())
			{
				RandomAccessFile inFile = new RandomAccessFile (galleryFile, "r");

				//
				// determine if the gallery object already exists in the gallery
				//
				while (inFile.getFilePointer () != inFile.length ())
				{
					//
					// read a temporary gallery object from the gallery file
					//
					tempGallery.readBought (inFile);

					//
					// check if there is a match with the gallery object
					//
					if ((OsbertUtilities.removeQuestionMarks (tempGallery.firstName).compareTo
							(OsbertUtilities.removeQuestionMarks (firstName)) == 0) &&
							(OsbertUtilities.removeQuestionMarks (tempGallery.lastName).
							compareTo (OsbertUtilities.removeQuestionMarks (lastName)) == 0) &&
							(OsbertUtilities.removeQuestionMarks (tempGallery.title).compareTo
							(OsbertUtilities.removeQuestionMarks (title)) == 0))

					{
						found = true;
						break;
					}
				} // while (inFile.getFilePointer () != inFile.length ())

				inFile.close ();
			} // if (galleryFile.exists ()

			if (found)
			{
				System.out.println ();
				System.out.println ();

				System.out.println ("The painting you described has already been purchased!\n");
			}
			else
			{
				determineAlgorithmPrice ();

				System.out.println ();
				System.out.println ();

				if (algorithmPrice > 0)
				{
					System.out.print ("The algorithm has determined the");
              System.out.println (" maximum offering price to be: ");
					System.out.println ("$" + algorithmPrice + ".\n");

					System.out.print ("Do you want to purchase this painting (Y/N)? ");
					System.in.read (ch);

					if (( (char) ch[0] == 'Y') || ((char) ch[0] == 'y'))
					{
						getGalleryInformation ();
						addNewPainting ();
					}
				}
				else
				{
					System.out.print ("The algorithm has suggested");
          System.out.println (" that you should not buy this painting.");
				} // if (algorithmPrice > 0)

			} // if (found)...else

			System.out.println ();
			System.out.println ();

			System.out.println ("Press <ENTER> to return to main menu...");
      OsbertUtilities.pressEnter();

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: GalleryClass.buy () *****");
			System.out.println ("\t" + e);
		}

		} // buy

	public void boughtReport ()
	//
	// boughtReport displays a report of bought paintings
	//
	{

		try
		{
			File			galleryFile = new File ("gallery.dat");

			OsbertDate	oneLess = new OsbertDate ();	// date one year ago today
			OsbertDate	currentDate = new OsbertDate ();
			int			i;			// counts number of paintings in report
			float			totalPurchase;	// sum of actual purchase prices
			float			totalMax;	// sum of maximum purchase prices

			totalPurchase = (float) 0.0;
			totalMax = (float) 0.0;
			i = 0;

			OsbertUtilities.clearScreen ();
			oneLess.setYear (oneLess.getYear () - 1);

			if (galleryFile.exists ())
			{
				RandomAccessFile inFile = new RandomAccessFile (galleryFile, "r");

				//
				// read in all paintings from the gallery and
				// determine if they are candidates for the bought report
				//
				while (inFile.getFilePointer () != inFile.length ())
				{
					//
					// read a gallery object from the gallery file
					//
					readBought (inFile);

					//
					// check if the painting was purchased within the past year
					//
					if (oneLess.compareTo (purchaseDate) <= 0)
					{
						//
						// pause the screen after every three paintings
						//
						if (( (i % 3) == 0) && (i != 0))
						{
							System.out.println ();
							System.out.println ();
							System.out.println (" Press <ENTER> to view the next screen...");
              OsbertUtilities.pressEnter();
						}

						//
						// display a header message after every third painting
						//
						if ((i % 3) == 0)
						{
							OsbertUtilities.clearScreen ();

							System.out.println ();
							System.out.println ();
							System.out.println ("\t               Report Date: " + currentDate.toString ());
							System.out.println ("\t      Osbert Oglesby - Collector of Fine Art");
							System.out.println ("\t                  BOUGHT PAINTINGS\n");
						}

						System.out.println ("-----------------------------------------------------------------------------");
						System.out.print ("CLASSIFICATION: ");

						if (purchasePrice > algorithmPrice)
							System.out.print ("*");

						System.out.print (classification + "   ");
						System.out.println ("\tPURCHASE DATE:  " + purchaseDate.toString ());
						System.out.print ("LAST NAME:      " + lastName);
						System.out.println ("\t\tTITLE:          " + title);
						System.out.print ("SUGG. PRICE:    $" + algorithmPrice);
						System.out.println ("\t\tPURCHASE PRICE: $" + purchasePrice);

						totalPurchase = totalPurchase + purchasePrice;
						totalMax = totalMax + algorithmPrice;

						i++;
					}
				}
           inFile.close ();
        }

			if (totalMax > 0)
			{
				System.out.println ();
				System.out.println ();
				System.out.println ("Average ratio: " + (totalPurchase / totalMax));
			}
			else
				System.out.println ("There have been no paintings bought within the past year.");

			System.out.println ();
			System.out.println ();
			System.out.println (" Press <ENTER> to return to main menu...");
      OsbertUtilities.pressEnter();

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: GalleryClass.boughtReport () *****");
			System.out.println ("\t" + e);
		}

	} // boughtReport

	public void readBought (RandomAccessFile fileName)
	//
	// readBought reads a gallery object from fileName
	//
	{
		try
		{
			String inputString = new String ();
			int i = 0;

			inputString = fileName.readLine ();

			StringBuffer input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			classification = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			firstName = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			lastName = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			title = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			paintingDate = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			purchaseDate = new OsbertDate (input.toString ());
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			medium = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			subject = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			sellerName = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			sellerAddress = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			Float tempFloat = new Float (input.toString ());
			algorithmPrice = tempFloat.floatValue ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			tempFloat = new Float (input.toString ());
			purchasePrice = tempFloat.floatValue ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			tempFloat = new Float (input.toString ());
			targetPrice = tempFloat.floatValue ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			tempFloat = new Float (input.toString ());
			height = tempFloat.floatValue ();
			i++;

			input = new StringBuffer ();
			while (i < inputString.length ())
			{
				input.append (inputString.charAt (i));
				i++;
			}
			tempFloat = new Float (input.toString ());
			width = tempFloat.floatValue ();

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: GalleryClass.readBought () *****");
			System.out.println ("\t" + e);
		}

	} // readBought

	public void writeBought (RandomAccessFile fileName)
	//
	// writeBought writes a gallery object to fileName
	//
	{
		try
		{

			fileName.writeBytes (classification + "|" + firstName + "|" + lastName + "|");
			fileName.writeBytes (title + "|" + paintingDate + "|" + purchaseDate.toString () + "|");
			fileName.writeBytes (medium + "|" + subject + "|" + sellerName + "|" + sellerAddress + "|");
			fileName.writeBytes (algorithmPrice + "|" + purchasePrice + "|" + targetPrice + "|");
			fileName.writeBytes (height + "|" + width + "\n");

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: GalleryClass.writeBought () *****");
			System.out.println ("\t" + e);
		}

	} // writeBought

	public void addNewSale ()
	//
	// addNewSale records that a gallery painting has been sold
	//
	{
		try
		{

			File soldFile = new File ("sold.dat");
			File tempSoldFile = new File ("sold.tmp");

			if (!soldFile.exists ())
			{
				RandomAccessFile newFile = new RandomAccessFile (soldFile, "rw");
				writeSold (newFile);
				newFile.close ();
				return;
			}

			boolean found;		// indicates if object insertion point found
			GalleryClass tempGallery = new GalleryClass ();
											// temporary object used for file copying

			found = false;

			RandomAccessFile inFile = new RandomAccessFile (soldFile, "r");
			RandomAccessFile outFile = new RandomAccessFile (tempSoldFile, "rw");

			//
			// copy the temporary file to a new sold file
			// while inserting the painting object in the proper location
			//
			while (inFile.getFilePointer () != inFile.length ())
			{
				//
				// read a temporary gallery object from the temporary file
				//
				tempGallery.readSold (inFile);

				//
				// write the proper object to the sold file
				//
				if ((tempGallery.classification.compareTo (classification) <= 0) &&
					(tempGallery.saleDate.compareTo (saleDate) <= 0) &&
					!found)
				{
					//
					// write the gallery object to the sold file
					//
					writeSold (outFile);

					//
					// write the temporary gallery object to the sold file
					//
					tempGallery.writeSold (outFile);

					found = true;
				}
				else
					tempGallery.writeSold (outFile);

			} // while (!inFile.eof ())

			//
			// write the gallery object to the end of the sold file
			//
			if (!found)
				writeSold (outFile);

			inFile.close ();
			outFile.close ();

			soldFile.delete ();
			tempSoldFile.renameTo (soldFile);

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: GalleryClass.addNewSale () *****");
			System.out.println ("\t" + e);
		}

	} // addNewSale

	public void sell ()
	//
	// sell allows user to sell a painting found in the gallery
	//
	{
		try
		{
			File		soldFile = new File ("sold.dat");
			boolean	found;		// indicates if painting already in gallery
			boolean	alreadySold;	// indicates if painting already sold
			String	tempFN;	// tempFN, tempLN, and tempTitle
			String	tempLN;	// store temporary information about
			String	tempTitle;	// the painting to be sold, namely first name,
											// last name, and title, resp.
			char c;

			OsbertUtilities.clearScreen ();

			//
			// retrieve information about the painting desired to be sold
			//
			System.out.println ();
			System.out.println ();
			System.out.println ("Please enter the following information describing the painting:\n");
			System.out.println ("      Do not leave any items blank.\n\n");

			System.out.print ("Enter the FIRST name of the artist (append ? if uncertain): ");
			tempFN = OsbertUtilities.readString();

			System.out.print ("Enter the LAST name of the artist (append ? if uncertain): ");
			tempLN = OsbertUtilities.readString();

			System.out.print ("Enter the TITLE of the painting (append ? if uncertain): ");
			tempTitle = OsbertUtilities.readString();

			alreadySold = false;

			if (soldFile.exists ())
			{
				RandomAccessFile inFile = new RandomAccessFile (soldFile, "r");

				//
				// determine if the desired painting has already been sold
				//
				while (inFile.getFilePointer () != inFile.length ())
				{
					//
					// read a gallery object from the sold file
					//
					readSold (inFile);

					//
					// check if there is a match with the gallery object
					//
					if ((OsbertUtilities.removeQuestionMarks (firstName).compareTo
							(OsbertUtilities.removeQuestionMarks (tempFN)) == 0) &&
							(OsbertUtilities.removeQuestionMarks (lastName).compareTo
							(OsbertUtilities.removeQuestionMarks (tempLN)) == 0) &&
							(OsbertUtilities.removeQuestionMarks (title).compareTo
							(OsbertUtilities.removeQuestionMarks (tempTitle)) == 0))

					{  alreadySold = true; break;	}
				}
           inFile.close ();
        }

			if (alreadySold)
			{
				System.out.println ();
				System.out.println ();
				System.out.println ("The painting you described has already been sold!\n");
			}
			else
			{
				found = false;

				File galleryFile = new File ("gallery.dat");

				if (galleryFile.exists ())
				{
					RandomAccessFile inFile = new RandomAccessFile (galleryFile, "r");

					//
					// check to make sure that the desired painting
					// actually exists in the gallery
					//
					while (inFile.getFilePointer () != inFile.length ())
					{
						//
						// read a gallery object from the gallery file
						//
						readBought (inFile);

						//
						// check if there is a match with the desired painting
						//
						if ((OsbertUtilities.removeQuestionMarks (firstName).compareTo
								(OsbertUtilities.removeQuestionMarks (tempFN)) == 0) &&
								(OsbertUtilities.removeQuestionMarks (lastName).compareTo
								(OsbertUtilities.removeQuestionMarks (tempLN)) == 0) &&
								(OsbertUtilities.removeQuestionMarks (title).compareTo
								(OsbertUtilities.removeQuestionMarks (tempTitle)) == 0))

						{  found = true;	break; }
           	}
              inFile.close ();
           }

				if (found)
				{
					System.out.println ();
					System.out.println ();
					System.out.println ("Please enter the following sale information:\n\n");

					saleDate = new OsbertDate ();

					System.out.print ("Enter the NAME of the buyer: ");
					buyerName = OsbertUtilities.readString();

					System.out.print ("Enter the ADDRESS of the buyer: ");
					buyerAddress = OsbertUtilities.readString();

					System.out.print ("Enter the selling PRICE: ");
					Float tempFloat = new Float (OsbertUtilities.removeDollarSign (OsbertUtilities.readString()));
					sellPrice = tempFloat.floatValue ();

					addNewSale ();
					OsbertUtilities.addArtist (firstName, lastName);

					System.out.println ();
					System.out.println ();
					System.out.println ("The sale has been recorded.");
				}
				else
				{
					System.out.println ();
					System.out.println ();
					System.out.print ("The painting you described");
					System.out.println (" cannot be found in the gallery.");
					System.out.println ("Please make sure you entered the information correctly.");
					System.out.println ("Proper case is required.");
				}
			}

			System.out.println ();
			System.out.println ();
			System.out.println ("Press <ENTER> to return to main menu...");
      OsbertUtilities.pressEnter();

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: GalleryClass.sell () *****");
			System.out.println ("\t" + e);
		}

	} // sell

	public void sellReport ()
	//
	// displays a report of sold paintings
	//
	{
		try
		{
			File soldFile = new File ("sold.dat");
			OsbertDate oneLess = new OsbertDate ();		// date one year ago today
			OsbertDate currentDate = new OsbertDate ();
			int	  	i;				// counts number of paintings in report
			float		totalSelling;		// sum of actual selling prices
			float		totalTarget;		// sum of target prices

			totalSelling = (float) 0.0;
			totalTarget = (float) 0.0;
			i = 0;

			OsbertUtilities.clearScreen ();
			oneLess.setYear (oneLess.getYear () - 1);

			if (soldFile.exists ())
			{
				RandomAccessFile inFile = new RandomAccessFile (soldFile, "r");

				//
				// read in all paintings from the gallery and
				// determine if they are candidates for the sold report
				//
				while (inFile.getFilePointer () != inFile.length ())
				{
					//
					// read a gallery object from the sold file
					//
					readSold (inFile);

					//
					// check if the painting was sold within the past year
					//
					if (oneLess.compareTo (saleDate) <= 0)
					{
						//
						// pause the screen after every three paintings
						//
						if (( (i % 3) == 0) && (i != 0))
						{
							System.out.println ();
							System.out.println ();
							System.out.println ("Press <ENTER> to view the next screen...");
              OsbertUtilities.pressEnter();
						}

						//
						// display a header message after every third painting
						//
						if ((i % 3) == 0)
						{
							OsbertUtilities.clearScreen ();
							System.out.println ();
							System.out.println ();
							System.out.println ("\t               Report Date: " + currentDate.toString ());
							System.out.println ("\t      Osbert Oglesby - Collector of Fine Art");
							System.out.println ("\t                  SOLD PAINTINGS\n");
						}

						System.out.println ("-----------------------------------------------------------------------------");
						System.out.print ("CLASSIFICATION: ");

						if (sellPrice < (targetPrice * 0.95))
							System.out.print ("*");

						System.out.print (classification + "   ");
						System.out.println ("\tSALE DATE:     " + saleDate.toString ());
						System.out.print ("LAST NAME:      " + lastName);
						System.out.println ("\t\tTITLE:         " + title);
						System.out.print ("TARGET PRICE:   $" + targetPrice);
						System.out.println ("\t\tSELLING PRICE: $" + sellPrice);

						totalSelling = totalSelling + sellPrice;
						totalTarget = totalTarget + targetPrice;

						i++;

					}
				}

				inFile.close ();

			}

			System.out.println ();
			System.out.println ();

			if (totalTarget > 0)
				System.out.println ("Average ratio: " + (totalSelling / totalTarget));
			else
				System.out.println ("There have been no paintings sold within the past year.");

			System.out.println ();
			System.out.println ();
			System.out.println ("Press <ENTER> to return to main menu...");
      OsbertUtilities.pressEnter();

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: GalleryClass.sellReport () *****");
			System.out.println ("\t" + e);
		}

	} // sellReport

	public void readSold (RandomAccessFile fileName)
	//
	// readSold reads a sold gallery object from fileName
	//
	{
		try
		{
			String inputString = new String ();
			int i = 0;

			inputString = fileName.readLine ();

			StringBuffer input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			classification = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			firstName = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			lastName = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			title = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			paintingDate = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			purchaseDate = new OsbertDate (input.toString ());
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			saleDate = new OsbertDate (input.toString ());
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			medium = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			subject = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			sellerName = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			buyerName = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			sellerAddress = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			buyerAddress = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			Float tempFloat = new Float (input.toString ());
			algorithmPrice = tempFloat.floatValue ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			tempFloat = new Float (input.toString ());
			purchasePrice = tempFloat.floatValue ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			tempFloat = new Float (input.toString ());
			targetPrice = tempFloat.floatValue ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			tempFloat = new Float (input.toString ());
			sellPrice = tempFloat.floatValue ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			tempFloat = new Float (input.toString ());
			height = tempFloat.floatValue ();
			i++;

			input = new StringBuffer ();
			while (i < inputString.length ())
			{
				input.append (inputString.charAt (i));
				i++;
			}
			tempFloat = new Float (input.toString ());
			width = tempFloat.floatValue ();

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: GalleryClass.readSold () *****");
			System.out.println ("\t" + e);
		}

	} // readSold

	public void writeSold (RandomAccessFile fileName)
	//
	// writeSold writes a sold gallery object to fileName
	//
	{
		try
		{

			fileName.writeBytes (classification + "|" + firstName + "|" + lastName + "|");
			fileName.writeBytes (title + "|" + paintingDate + "|" + purchaseDate.toString () + "|");				fileName.writeBytes (saleDate.toString () + "|");
			fileName.writeBytes (medium + "|" + subject + "|" + sellerName + "|" + buyerName + "|");
			fileName.writeBytes (sellerAddress + "|" + buyerAddress + "|");
			fileName.writeBytes (algorithmPrice + "|" + purchasePrice + "|" + targetPrice + "|");
			fileName.writeBytes (sellPrice + "|" + height + "|" + width + "\n");

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: GalleryClass.writeSold () *****");
			System.out.println ("\t" + e);
		}

	} // writeSold

	public void fashionReport ()
	//
	// fashionReport displays a report of fashionable painters and their paintings
	//
	{
		try
		{
			File artistFile = new File ("artist.dat");
			File soldFile = new File ("sold.dat");
			OsbertDate oneLess = new OsbertDate ();	// date one year ago today
			OsbertDate currentDate = new OsbertDate ();
			int		i;			// counts number of paintings in report
			boolean	found;		// indicates if qualified artists were found
			String	tempFN;	// tempFN and tempLN
			String	tempLN;	// store values read from artist file,
											// namely first name and last name, resp.

			i = 0;
			found = false;

			OsbertUtilities.clearScreen ();
			oneLess.setYear (oneLess.getYear () - 1);

			if (artistFile.exists ())
			{
				RandomAccessFile art_file = new RandomAccessFile (artistFile, "r");

				//
				// read in all paintings from the gallery and
				// determine if they are candidates for the fashion report
				//
				while (art_file.getFilePointer () != art_file.length ())
				{
					//
					// read an artist name from the artist file
					//
					String inputString = art_file.readLine ();

					StringBuffer input = new StringBuffer ();
					int j = 0;
					char c;

					while ((c = inputString.charAt (j)) != '|')
					{
						input.append (c);
						j++;
					}
					tempFN = input.toString ();
					j++;

					input = new StringBuffer ();
					while (j < inputString.length ())
					{
						c = inputString.charAt (j);
						input.append (c);
						j++;
					}
					tempLN = input.toString ();

					//
					// check if all of their paintings have sold over the target price
					//
					if (OsbertUtilities.overTarget (tempFN, tempLN))
					{
						found = true;
						OsbertUtilities.clearScreen ();

						System.out.println ();
						System.out.println ();
						System.out.println ("\t               Report Date: " + currentDate.toString ());
						System.out.println ("\t      Osbert Oglesby - Collector of Fine Art");
						System.out.println ("\t                  FASHION TRENDS\n");

						System.out.println ("Painter: " + tempFN + " " + tempLN);

						if (soldFile.exists ())
						{
							RandomAccessFile sold_file = new RandomAccessFile (soldFile, "r");

							//
							// examine every sold painting of the current artist
							// indicated by tempFN, tempLN
							//
							while (sold_file.getFilePointer () != sold_file.length ())
							{
								//
								// read a painting object from the sold file
								//
								readSold (sold_file);

								//
								// check if the painting was sold within the past year
								// and make sure it was painted by the current artist
								//
								if ((oneLess.compareTo (saleDate) <= 0) &&
										(OsbertUtilities.removeQuestionMarks (tempFN).
										compareTo (OsbertUtilities.removeQuestionMarks
										(firstName)) == 0) && (OsbertUtilities.removeQuestionMarks
										(tempLN).compareTo (OsbertUtilities.removeQuestionMarks
										(lastName)) == 0))
								{
									//
									// pause the screen after every three paintings
									//
									if (( (i % 3) == 0) && (i != 0))
									{
										System.out.println ();
										System.out.println ();
										System.out.print ("Press <ENTER> to view ");
                    System.out.println (" the next screen...");
                    OsbertUtilities.pressEnter();

										OsbertUtilities.clearScreen ();
										System.out.println ();
										System.out.println ();
										System.out.println ("\t\t\t         Report Date:" + currentDate);
										System.out.print("\t\t\t Osbert Oglesby");
										System.out.println (" - Collector of Fine Art");
										System.out.println ("\t\t\t            FASHION TRENDS\n");

										System.out.println ("Painter: " + tempFN + " " + tempLN);
									}

									System.out.println ("--------------------------------------------------------------");

									System.out.print ("CLASSIFICATION: ");
									System.out.print (classification + "	");
									System.out.println ("\t\tTITLE: " + title);
									System.out.println ("SALE DATE:      " + saleDate.toString ());
									System.out.print ("TARGET PRICE:   $" + targetPrice);
									System.out.println ("\t\tSELLING PRICE: $" + sellPrice);

									i++;
								}
							}

							sold_file.close ();
						}

						System.out.println ();
						System.out.println ();
						System.out.println ("Press <ENTER> to continue...");
            OsbertUtilities.pressEnter();

						i = 0;
					}
				}

				art_file.close ();
			} // if (art_file)

			if (!found)
			{
				System.out.println ("There are no artists who qualify for this report...");

				System.out.println ();
				System.out.println ();
				System.out.println ("Press <ENTER> to return to main menu...");
        OsbertUtilities.pressEnter();
			}

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: GalleryClass.fashionReport () *****");
			System.out.println ("\t" + e);
		}

	} // fashionReport

	protected void determineAlgorithmPrice ()	{ }

} // class GalleryClass


/****************************************************************************
 *
 *					 	Class AuctionClass
 *
 ****************************************************************************/
/*														*/
/*		protected OsbertDate auctionDate;				*/
/*		protected float auctionPrice;				*/
/*														*/
/*		AuctionClass ();								*/
/*														*/
/*		public float getAuctionPrice ();				*/
/*		public OsbertDate getAuctionDate ()				*/
/*		public void readAuction (RandomAccessFile);			*/
/*														*/
/*--------------------------------------------------------------------------*/

class AuctionClass extends PaintingClass
{
	public AuctionClass ()				{ }

	//
	// class data members
	//
	protected OsbertDate auctionDate;	// date painting sold at auction
	protected float auctionPrice;		// auction price of painting


	//
	// data member access functions
	//
	public OsbertDate getAuctionDate ()	{ return auctionDate; }
	public float getAuctionPrice ()		{ return auctionPrice; }

	//
	// class member function
	//
	public void readAuction (RandomAccessFile fileName)
	//
	// readAuction reads an auction object from fileName
	//
	{
		try
		{
			String inputString = new String ();
			int i = 0;

			inputString = fileName.readLine ();

			StringBuffer input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			firstName = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			lastName = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			title = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			paintingDate = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			Float tempFloat = new Float (input.toString ());
			height = tempFloat.floatValue ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			tempFloat = new Float (input.toString ());
			width = tempFloat.floatValue ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			medium = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			subject = input.toString ();
			i++;

			input = new StringBuffer ();
			while (inputString.charAt (i) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			auctionDate = new OsbertDate (input.toString ());
			i++;

			input = new StringBuffer ();
			while (i < inputString.length ())
			{
				input.append (inputString.charAt (i));
				i++;
			}
			tempFloat = new Float (input.toString ());
			auctionPrice = tempFloat.floatValue ();

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: AuctionClass.readAuction () *****");
			System.out.println ("\t" + e);
		}

	} // readAuction

} // class AuctionClass


/***************************************************************************
 *
 *					 	Class MasterpieceClass
 *
 ****************************************************************************/
/*														*/
/*		MasterpieceClass ()							*/
/*														*/
/*		public void determineAlgorithmPrice ()				*/
/*														*/
/*--------------------------------------------------------------------------*/

class MasterpieceClass extends GalleryClass
{

	public MasterpieceClass ()			{ classification = "Masterpiece"; }

	public void determineAlgorithmPrice ()
	//
	// determineAlgorithmPrice determines the maximum price to be offered for a masterpiece
	//
	{
		try
		{
			File auctionData = new File ("auction.dat");

			if (auctionData.exists ())
			{
				float			high;		// keeps track of highest similarity
				float			algHigh;	// price of most similar work
				float			temp;		// number of matches on medium/subject
				float			auctionArea;	// area of an auction painting
				float			galleryArea;	// area of a gallery painting
				int			i;			// loop iterator for compound interest
				int			auctionYear;	// year of auction painting sale date
				int			currentYear;	// year component of currentDate
				OsbertDate	highDate = new OsbertDate ();	// date of most similar work
				AuctionClass	tempAuction = new AuctionClass ();
											// temporary object used for file reading

				high = (float) 0.0;
				algHigh = (float) 0.0;

				RandomAccessFile inFile = new RandomAccessFile (auctionData, "r");

				//
				// loop through all of the auction objects and find the most similar work
				//
				while (inFile.getFilePointer () != inFile.length ())
				{
					//
					// read an auction object
					//
					tempAuction.readAuction (inFile);

					temp = (float) 0.0;

					//
					// if the artist names match, compute the similarity
					//
					if ((OsbertUtilities.removeQuestionMarks (tempAuction.getFirstName ()).
							compareTo (OsbertUtilities.removeQuestionMarks (firstName)) == 0) &&
							(OsbertUtilities.removeQuestionMarks (tempAuction.getLastName ()).
							compareTo (OsbertUtilities.removeQuestionMarks (lastName)) == 0))

					{
						if (tempAuction.getMedium ().compareTo (medium) == 0)
						{
							temp++;
						}

						if (tempAuction.getSubject ().compareTo (subject) == 0)
						{
							temp++;
						}

						auctionArea = tempAuction.getHeight () * tempAuction.getWidth ();
						galleryArea = height * width;

						if (auctionArea > galleryArea)
						{
							temp = temp * galleryArea / auctionArea;
						}
						else
						{
							temp = temp * auctionArea / galleryArea;
						}

						//
						// a higher similarity was found...
						//
						if (temp > high)
						{
							high = temp;
							algHigh = tempAuction.getAuctionPrice ();
							highDate = new OsbertDate (tempAuction.getAuctionDate ());
						}
					}
				}

				inFile.close ();

				auctionYear = highDate.getYear ();

				OsbertDate currentDate = new OsbertDate ();
				currentYear = currentDate.getYear ();

				//
				// compute the compound interest
				//
				for (i = auctionYear; i < currentYear; i++)
				{
					algHigh = algHigh * OsbertApplication.ANNUAL_INTEREST;
				}

				algorithmPrice = algHigh;
			}

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: MasterpieceClass.determineAlgorithmPrice () *****");
			System.out.println ("\t" + e);
		}

	} // determineAlgorithmPrice

} // class MasterpieceClass


/***************************************************************************
 *
 *						 	Class MasterworkClass
 *
 ***************************************************************************/
/*														*/
/*		MasterworkClass ()								*/
/*														*/
/*		public void determineAlgorithmPrice ()				*/
/*														*/
/*------------------------------------------------------------------------*/

class MasterworkClass extends MasterpieceClass
{

	public MasterworkClass ()				{ classification = "Masterwork"; }

	public void determineAlgorithmPrice ()
	//
	// determines the maximum price to be offered for a masterwork
	//
	{
		int century;	// century in which painting was created

		//
		// first, compute the price of the painting as if it were a masterpiece
		//
		super.determineAlgorithmPrice ();

		//
		// next, obtain the century in which the painting was created and adjust
		// the price based upon the century
		//
		Integer tempInt = new Integer (OsbertUtilities.removeQuestionMarks (paintingDate));

		century = tempInt.intValue () / 100;

		if (century == 19)
			algorithmPrice = algorithmPrice * (float) 0.25;
		else
			algorithmPrice = algorithmPrice * (20 - century) / (21 - century);

	} // determineAlgorithmPrice

} // class MasterworkClass

/***************************************************************************
 *
 *						Class OtherClass
 *
 ***************************************************************************/
/*														*/
/*		OtherClass ()									*/
/*														*/
/*		public void determineAlgorithmPrice ()				*/
/*														*/
/*-------------------------------------------------------------------------*/


class OtherClass extends GalleryClass
{
	public OtherClass ()					{ classification = "Other"; }

	public void determineAlgorithmPrice ()
	//
	// determines the maximum price to be offered for an "other" piece of work
	//
	{
		try
		{
			File fashFile = new File ("fash.dat");
			float fashionCoefficient;		// current coefficient of painting artist

			fashionCoefficient = (float) 0.0;

			if (fashFile.exists ())
			{
				FashionabilityClass tempFash = new FashionabilityClass ();
											// temp. fashionability object used for file reading

				RandomAccessFile inFile = new RandomAccessFile (fashFile, "r");

				//
				// loop through the fashionability file to find a match with the artist
				//
				while (inFile.getFilePointer () != inFile.length ())
				{
					//
					// read in an object from the fashionability file
					//
					tempFash.readFash (inFile);

					//
					// check if there is a match with the current other object
					//
					if ((OsbertUtilities.removeQuestionMarks (tempFash.getFirstName ()).
							compareTo (OsbertUtilities.removeQuestionMarks (firstName)) == 0) &&
							(OsbertUtilities.removeQuestionMarks (tempFash.getLastName ()).								compareTo (OsbertUtilities.removeQuestionMarks (lastName)) == 0))

					{
						fashionCoefficient = tempFash.getCoefficient ();
						break;
					}
				}

				inFile.close ();

			}

			algorithmPrice = fashionCoefficient * height * width;

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: OtherClass.determineAlgorithmPrice () *****");
			System.out.println ("\t" + e);
		}

	} // determineAlgorithmPrice

} // class OtherClass


/***************************************************************************
 *
 *				  		Class FashionabilityClass
 *
 ***************************************************************************/
/*		protected String firstName					*/
/*		protected String lastName					*/
/*		protected float coefficient					*/
/*														*/
/*		FashionabilityClass ()							*/
/*														*/
/*		public float getCoefficient ()					*/
/*		public String getFirstName ()					*/
/*		public String getLastName ()					*/
/*														*/
/*		public void addNewFash ()					*/
/*		public void getDescription ()					*/
/*		public void readFash (RandomAccessFile)				*/
/*		public void writeFash (RandomAccessFile)				*/
/*														*/
/*-------------------------------------------------------------------------*/

class FashionabilityClass
{
  // constructor
	public FashionabilityClass ()			{ }

	//
	// class data members
	//
	protected String firstName;			// first name of artist
	protected String lastName;			// last name of artist
	protected float coefficient;			// fashionability coefficient


	//
	// data member access functions
	//
	public String getFirstName ()			{ return firstName; }
	public String getLastName ()			{ return lastName; }
	public float getCoefficient ()			{ return coefficient; }

	//
	// class member functions
	//
	public void getDescription ()
	//
	// retrieves fashionability description information
	//
	{
		try
		{
			StringBuffer input;
			char c;

			OsbertUtilities.clearScreen ();

			//
			// request fashionability object information
			//
			System.out.println ("Please enter the following information concerning the artist whose");
			System.out.println ("fashionability coefficient you wish to change.\n");
			System.out.println ("			- Do not leave any request blank.\n\n");

			System.out.print ("Enter the FIRST name of the artist: ");
			firstName = OsbertUtilities.readString();

			System.out.print ("Enter the LAST name of the artist: ");
			lastName = OsbertUtilities.readString();

			System.out.print ("Enter the new fashionability coefficient for this artist: ");
			Float tempFloat = new Float (OsbertUtilities.readString());
			coefficient = tempFloat.floatValue ();

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: FashionabilityClass.getDescription () *****");
			System.out.println ("\t" + e);
		}

	} // getDescription

	public void addNewFash ()
	//
	// addNewFash allows the user to add/update the fashionability coefficient
	// of an object of FashionabilityClass
	//
	{
		try
		{
			File fashFile = new File ("fash.dat");
			File tempFashFile = new File ("fash.tmp");

			boolean found;				// indicates if object insertion point found
			FashionabilityClass tempFash = new FashionabilityClass ();
											// temporary object used for file copying

			//
			// obtain information about the new fashionability object
			//
			getDescription ();

			found = false;

			if (!fashFile.exists ())
			{
				RandomAccessFile newFile = new RandomAccessFile (fashFile, "rw");
				newFile.writeBytes (firstName + "|" + lastName + "|" + coefficient + "\n");
				newFile.close ();
				return;
			}

			// stream object used for file input
			RandomAccessFile inFile = new RandomAccessFile (fashFile, "r");

			// stream object used for file output
			RandomAccessFile outFile = new RandomAccessFile (tempFashFile, "rw");

			//
			// copy the temporary file to a new fashionability file
			// while updating/inserting the fashionability object
			//
			while (inFile.getFilePointer () != inFile.length ())
			{
				//
				// read a temporary fashionability object from the temporary file
				//
				tempFash.readFash (inFile);

				//
				// write the proper object to the fashionability file
				//
				if ((OsbertUtilities.removeQuestionMarks (tempFash.firstName).compareTo
						(OsbertUtilities.removeQuestionMarks (firstName)) == 0) &&
						(OsbertUtilities.removeQuestionMarks (tempFash.lastName).compareTo
						(OsbertUtilities.removeQuestionMarks (lastName)) == 0))

				{
					writeFash (outFile);
					found = true;
				}
				else
					tempFash.writeFash (outFile);

			} // while (!inFile.eof ())

			inFile.close ();

			//
			// write the fashionability object to the end of the fashionability file
			//
			if (!found)
				writeFash (outFile);

			outFile.close ();

			fashFile.delete ();
			tempFashFile.renameTo (fashFile);

			System.out.println ();
			System.out.println ();
			System.out.println ("Press <ENTER> to return to main menu...");
      OsbertUtilities.pressEnter();
		}
		catch (Exception e)
		{
			System.out.println ("***** ERROR: FashionabilityClass.addNewFash () *****");
			System.out.println ("\t" + e);
		}

	} // addNewFash

	public void readFash (RandomAccessFile fileName)
	//
	// readFash reads a fashionability object from fileName
	//
	{
		try
		{
			String inputString = new String ();
			int i = 0;
			char c;

			inputString = fileName.readLine ();

			StringBuffer input = new StringBuffer ();
			while ((c = inputString.charAt (i)) != '|')
			{
				input.append (c);
				i++;
			}
			firstName = input.toString ();
			i++;

			input = new StringBuffer ();
			while ((c = inputString.charAt (i)) != '|')
			{
				input.append (inputString.charAt (i));
				i++;
			}
			lastName = input.toString ();
			i++;

			input = new StringBuffer ();
			while (i < inputString.length ())
			{
				input.append (inputString.charAt (i));
				i++;
			}
			Float tempFloat = new Float (input.toString ());
			coefficient = tempFloat.floatValue ();

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: FashionabilityClass.readFash () *****");
			System.out.println ("\t" + e);
		}

	} // readFash

	public void writeFash (RandomAccessFile fileName)
	//
	// writeFash writes a fashionability object to fileName
	//
	{
		try
		{
			fileName.writeBytes (firstName + "|" + lastName + "|" + coefficient + '\n');
		}
		catch (Exception e)
		{
			System.out.println ("***** Error: FashionabilityClass.writeFash () *****");
			System.out.println ("\t" + e);
		}

	} // writeFash

} // class FashionabilityClass
