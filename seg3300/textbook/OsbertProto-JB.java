//
// This rapid prototype was constructed using JBuilder 2.0 (JDK 1.1)
//

import java.io.*;
import java.util.*;
import java.text.*;

class Painting
{
	String					firstName;
	String					lastName;
	String					title;
	String					paintingDate;
	float					  	height;
	float				   	width;
	String					medium;
	String					subject;
}


class Auction
{
	Painting					description = new Painting ();
	Date					  	auctionDate;
	float					  	salePrice;
}


class Gallery
{
	String					classification;
	Painting					description = new Painting ();
	Date					  	purchaseDate;
	String					sellerName;
	String					sellerAddress;
	float				   	algorithmPrice;
	float			  			purchasePrice;
	float			   		targetPrice;
	Date				  		saleDate;
	String					buyerName;
	String					buyerAddress;
	float					   sellPrice;
}


class OsbertPrototype
{
	public static final int 	NUM_GALLERY_RECORDS = 10;
	public static final int 	NUM_AUCTION_RECORDS = 7;

	public static final float 	TARGET_MARKUP = (float) 2.15;
	public static final float 	ANNUAL_INTEREST = (float) 1.085;

	public int				galleryCount;
	public float			fash;

	//
	// Because this is a rapid prototype, an array of records has been used to keep
	// track of a fixed number of auction records and gallery records.
	//
	public Gallery			galleryRecords[] = new Gallery[NUM_GALLERY_RECORDS];

	public Auction			auctionRecords[] = new Auction[NUM_AUCTION_RECORDS];

//----------------------------------------------------------------------------------------------------------------------------------------------------

  public static char getChar()
  //
  // getChar returns the first character entered from the keyboard
  //
  {

	  char ch = '\n';

    try
    {
      Reader in = new InputStreamReader(System.in);
      ch=(char)in.read();
    }
    catch (Exception e)
    {
      System.out.println("Error: " + e.toString());
    }

    return ch;

  } // getChar

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

/*    return  tempBuffer.toString();     */

    // The following code is needed when using JBuilder in order to
    // remove a trailing space. It replaces the return statement
    // given above.
    tempString = tempBuffer.toString();
    for (i=0; i<tempString.length() - 1; i++)
      sb.append(tempString.charAt(i));

    return sb.toString();


  }
  public static void pressEnter()
  //
  // pressEnter waits until the user presses the <ENTER> key
  //
  {

	  char				ch = '\n';

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
	// Clears the screen
	//
	{
		int i;	// loop counter representing the number of blank lines to be printed

	//
	// Implementation-dependent code to clear the screen should replace the code
	// given below.
	//

		for (i = 0; i < 26; i++)

		{
			System.out.println ();
		}
	} // clearScreen

//----------------------------------------------------------------------------------------------------------------------------------------------------

	public void initializeClass ()
	//
	// initializeClass initializes the gallery and auction records
	//
	{
		int					i;

		galleryCount = 0;
		fash = (float) 0.5;

		for (i = 0; i < NUM_GALLERY_RECORDS; i++)
		{
			galleryRecords[i] = new Gallery ();
			galleryRecords[i].sellPrice = (float) -1.0;
		}

		initializeAuctionRecords ();

	} // initialize

//----------------------------------------------------------------------------------------------------------------------------------------------------

  private Date convertDate (String newDateStr)
  //
  //  convert a string representation of a date to an object of type Date
  //
  {
    SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy"); // used to parse a date
    Date             newDate = new Date();

    try
    {
      newDate = dateFormat.parse(newDateStr);
    }
    catch (ParseException pe)
    {
  	  System.out.println("Unexpected error in creating date.");
    }

    return newDate;

  }

	public void initializeAuctionRecords ()
	//
	// initializeAuctionRecords initializes the auction records
	//
	{

		auctionRecords[0] 					= new Auction ();
		auctionRecords[0].description.firstName 	= "Leonardo";
		auctionRecords[0].description.lastName 	= "da Vinci";
		auctionRecords[0].description.title 	= "Ceiling Painting";
		auctionRecords[0].description.paintingDate 	= "1530";
		auctionRecords[0].description.height 	= (float) 482.5;
		auctionRecords[0].description.width 	= (float) 530.9;
		auctionRecords[0].description.medium 	= "oil";
		auctionRecords[0].description.subject 	= "other";
		auctionRecords[0].auctionDate 	= convertDate("11/20/1970");
		auctionRecords[0].salePrice 		= (float) 343.4;

		auctionRecords[1] 					= new Auction ();
		auctionRecords[1].description.firstName 	= "Rembrandt";
		auctionRecords[1].description.lastName 	= "van Rijn";
		auctionRecords[1].description.title 	= "The Day Watch";
		auctionRecords[1].description.paintingDate 	= "1650";
		auctionRecords[1].description.height 	= (float) 90.7;
		auctionRecords[1].description.width 	= (float) 41.3;
		auctionRecords[1].description.medium 	= "oil";
		auctionRecords[1].description.subject 	= "still life";
		auctionRecords[1].auctionDate 	= convertDate("03/16/1973");
		auctionRecords[1].salePrice 		= (float) 913.6;

		auctionRecords[2] 					= new Auction ();
		auctionRecords[2].description.firstName 	= "Frans";
		auctionRecords[2].description.lastName 	= "Hals";
		auctionRecords[2].description.title 	= "The Manic-Depressive Cavalier";
		auctionRecords[2].description.paintingDate 	= "1616";
		auctionRecords[2].description.height 	= (float) 103.3;
		auctionRecords[2].description.width 	= (float) 61.7;
		auctionRecords[2].description.medium 	= "oil";
		auctionRecords[2].description.subject 	= "portrait";
		auctionRecords[2].auctionDate 	= convertDate("04/22/1986");
		auctionRecords[2].salePrice 		= (float) 230.4;

		auctionRecords[3] 					= new Auction ();
		auctionRecords[3].description.firstName 	= "Edouard";
		auctionRecords[3].description.lastName 	= "Manet";
		auctionRecords[3].description.title 	= "Portrait of Claude Monet";
		auctionRecords[3].description.paintingDate 	= "1871";
		auctionRecords[3].description.height 	= (float) 43.6;
		auctionRecords[3].description.width 	= (float) 51.4;
		auctionRecords[3].description.medium 	= "watercolor";
		auctionRecords[3].description.subject 	= "portrait";
		auctionRecords[3].auctionDate 	= convertDate("01/04/1972");
		auctionRecords[3].salePrice 		= (float) 716.1;

		auctionRecords[4] 					= new Auction ();
		auctionRecords[4].description.firstName 	= "Claude";
		auctionRecords[4].description.lastName 	= "Monet";
		auctionRecords[4].description.title 	= "Portrait of Edouard Manet";
		auctionRecords[4].description.paintingDate 	= "1871";
		auctionRecords[4].description.height 	= (float) 43.6;
		auctionRecords[4].description.width 	= (float) 51.4;
		auctionRecords[4].description.medium 	= "watercolor";
		auctionRecords[4].description.subject 	= "portrait";
		auctionRecords[4].auctionDate 	= convertDate("01/04/1972");
		auctionRecords[4].salePrice 		= (float) 541.1;

		auctionRecords[5] 					= new Auction ();
		auctionRecords[5].description.firstName 	= "Vintcent";
		auctionRecords[5].description.lastName 	= "van Gogh";
		auctionRecords[5].description.title 	= "Irises, Sunflowers, Wheat, and Stuff";
		auctionRecords[5].description.paintingDate 	= "1888";
		auctionRecords[5].description.height 	= (float) 174.2;
		auctionRecords[5].description.width 	= (float) 89.9;
		auctionRecords[5].description.medium 	= "oil";
		auctionRecords[5].description.subject 	= "landscape";
		auctionRecords[5].auctionDate 	= convertDate("10/30/1984");
		auctionRecords[5].salePrice 		= (float) 336.1;

		auctionRecords[6] 					= new Auction ();
		auctionRecords[6].description.firstName 	= "Georges";
		auctionRecords[6].description.lastName 	= "Seurat";
		auctionRecords[6].description.title 	= "Lots of Tiny Little Dots";
		auctionRecords[6].description.paintingDate 	= "1889";
		auctionRecords[6].description.height 	= (float) 206.1;
		auctionRecords[6].description.width 	= (float) 307.6;
		auctionRecords[6].description.medium 	= "oil";
		auctionRecords[6].description.subject 	= "landscape";
		auctionRecords[6].auctionDate 	= convertDate("06/29/1990");
		auctionRecords[6].salePrice 		= (float) 4569.45;
	}

//----------------------------------------------------------------------------------------------------------------------------------------------------

	public void getDescription (Painting description)
	//
	// getDescription retrieves painting description information
	//
	{
		try
		{

			clearScreen ();
			System.out.println ("Please enter the following information about the painting:");
			System.out.println ();
			System.out.println ();

			System.out.print ("Enter the FIRST name of the artist: ");
			description.firstName = readString();

			System.out.print ("Enter the LAST name of the artist: ");
			description.lastName = readString();

			System.out.print ("Enter the TITLE of the painting: ");
			description.title = readString();;

			System.out.print ("Enter the DATE the painting was created (yyyy): ");
			description.paintingDate = readString();

			System.out.print ("Enter the HEIGHT of the painting: ");
			Float tempFloat = new Float (readString());
			description.height = tempFloat.floatValue ();

			System.out.print ("Enter the WIDTH of the painting: ");
			tempFloat = new Float (readString());
			description.width = tempFloat.floatValue ();

			System.out.print ("Enter the MEDIUM of the painting: ");
			description.medium = readString();

			System.out.print ("Enter the SUBJECT of the painting: ");
			description.subject = readString();

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: getDescription *****");
			System.out.println ("\t" + e);
		}

	} // getDescription

//----------------------------------------------------------------------------------------------------------------------------------------------------

	public void getPurchaseInformation (Gallery galleryRecord)
	//
	// getPurchaseInformation retrieves additional painting information for gallery record
	//
	{
		try
		{

			galleryRecord.purchaseDate = new Date ();

			System.out.print ("Enter the NAME of the seller: ");
			galleryRecord.sellerName = readString();

			System.out.print ("Enter the ADDRESS of the seller: ");
			galleryRecord.sellerAddress = readString();

			System.out.print ("Enter the purchase PRICE of the painting: ");
			Float tempFloat = new Float (readString());
			galleryRecord.purchasePrice = tempFloat.floatValue ();

			galleryRecord.targetPrice = galleryRecord.purchasePrice * TARGET_MARKUP;

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: getPurchaseInformation *****");
			System.out.println ("\t" + e);
		}

	} // getPurchaseInformation

//----------------------------------------------------------------------------------------------------------------------------------------------------

	public void insertRecord (Gallery theRecord)
	//
	// insertRecord inserts gallery record into proper place
	//
	{
		int					  i;
		int				  	tempCount;
		boolean				found;
		Gallery 			temp[] = new Gallery[NUM_GALLERY_RECORDS];

		tempCount = 0;
		found = false;

		for (i = 0; i < galleryCount; i++)
		{
			if ((theRecord.classification.compareTo (galleryRecords[i].classification) <= 0) &&
					(!theRecord.purchaseDate.after(galleryRecords[i].purchaseDate)) && !found)

			{
				temp[tempCount++] = theRecord;
				temp[tempCount++] = galleryRecords[i];
				found = true;
			}
			else
				temp[tempCount++] = galleryRecords[i];
		}

		if (!found)
			temp[tempCount++] = theRecord;

		galleryCount++;

		for (i = 0; i < galleryCount; i++)
			galleryRecords[i] = temp[i];

	} // insertRecord

//----------------------------------------------------------------------------------------------------------------------------------------------------

	public void addNewRecord (Gallery galleryRecord)
	//
	// addNewRecord determines if there is enough space to store new gallery record
	//
	{

		if (galleryCount < NUM_GALLERY_RECORDS)
			insertRecord (galleryRecord);
		else
		{
			System.out.println ("Storage for the static array has been exhausted.");
			System.out.println ("The record could not be inserted.");

			try
			{
				System.out.println ("\n\n    Press <ENTER> to continue");
				pressEnter();
			}
			catch (Exception e)
			{
				System.out.println ("***** Error: addNewRecord *****");
				System.out.println ("\t" + e);
			}
		}

	} // addNewRecord

//----------------------------------------------------------------------------------------------------------------------------------------------------

	public float determinePrice (Gallery galleryRecord)
	//
	// determinePrice determines maximum price to be offered for masterpiece
	//
	{
		float					high;
		float					algHigh;
		float					temp;
		float					auctionArea;
		float					galleryArea;
		int			  		i;
		int				  	index;
		boolean				found;
		int			  		auctionYear;
		int				  	currentYear;
		Date					today = new Date ();
    Calendar      c = new GregorianCalendar();

		high = (float) 0.0;
		index = 0;
		found = false;

		for (i = 0; i < NUM_AUCTION_RECORDS; i++)
		{
			temp = (float) 0.0;

			if ((auctionRecords[i].description.firstName.compareTo
					(galleryRecord.description.firstName) == 0) &&
					(auctionRecords[i].description.lastName.compareTo
					(galleryRecord.description.lastName) == 0))
			{
				if (auctionRecords[i].description.medium.compareTo
						(galleryRecord.description.medium) == 0)
					temp++;

				if (auctionRecords[i].description.subject.compareTo
						(galleryRecord.description.subject) == 0)
					temp++;

				auctionArea = auctionRecords[i].description.height *
						auctionRecords[i].description.width;
				galleryArea = galleryRecord.description.height * galleryRecord.description.width;

				if (auctionArea > galleryArea)
					temp = temp * galleryArea / auctionArea;
				else
					temp = temp * auctionArea / galleryArea;

				if (temp > high)
				{
					high = temp;
					index = i;
					found = true;
				}
			}
		} // for (i = 0; i < NUM_AUCTION_RECORDS; i++)

    c.setTime(auctionRecords[index].auctionDate);
		auctionYear = c.get(Calendar.YEAR) - 1900;

    c.setTime(today);
		currentYear= c.get(Calendar.YEAR) - 1900;

		algHigh = (float) 0.0;

		if (found)
			algHigh = auctionRecords[index].salePrice;

		for (i = auctionYear; i < currentYear; i++)
			algHigh = algHigh * ANNUAL_INTEREST;

		return algHigh;

	} // determinePrice

//----------------------------------------------------------------------------------------------------------------------------------------------------

	public void buyMasterpiece ()
	//
	// buyMasterpiece allows user to buy masterpiece
	//
	{
		try
		{
			char           ch='Y';
			Gallery			tempPainting = new Gallery ();

			tempPainting.classification = new String ("Masterpiece");

			getDescription (tempPainting.description);

			tempPainting.algorithmPrice = determinePrice (tempPainting);

			if (tempPainting.algorithmPrice > 0)
			{
				System.out.print ("\nThe algorithm determines the maximum price for this");
				System.out.print (" painting to be ");
				System.out.println ("$" + tempPainting.algorithmPrice + ".");
				System.out.println ();

				System.out.print ("Do you want to purchase this painting (Y/N)? ");

				try
				{
					ch=getChar();
				}
				catch (Exception e)
				{
					System.out.println ("***** Error: buyMasterpiece *****");
					System.out.println ("\t" + e);
				}

				if ((ch == 'Y') || (ch == 'y'))
				{
					getPurchaseInformation (tempPainting);
					addNewRecord (tempPainting);
				}
			}
			else
			{
				System.out.print ("\nThe algorithm has suggested that");
  			System.out.println (" you should not buy this painting.");

				System.out.println ("\n\n    Press <ENTER> to continue");
				pressEnter();
			}

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: buyMasterpiece *****");
			System.out.println ("\t" + e);
		}

	} // buyMasterpiece

//----------------------------------------------------------------------------------------------------------------------------------------------------

	public void buyMasterwork ()
	//
	// buyMasterwork allows user to buy masterwork
	//
	{
		try
		{
			clearScreen ();

			System.out.println ("This option is not implemented in the prototype.");
			System.out.println ("\n\n    Press <ENTER> to continue");
			pressEnter();

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: buyMasterwork *****");
			System.out.println ("\t" + e);
		}

	} // buyMasterwork

//----------------------------------------------------------------------------------------------------------------------------------------------------

	public void buyOther ()
	//
	// buyOther allows user to buy "other" type of painting
	//
	{
		char            ch='Y';
		Gallery					tempPainting = new Gallery ();

		tempPainting.classification = new String ("Other");

		getDescription (tempPainting.description);

		tempPainting.algorithmPrice = fash * tempPainting.description.height *
				tempPainting.description.width;

		if (tempPainting.algorithmPrice > 0)
		{
			System.out.print ("\nThe algorithm determines the maximum price for this painting");
			System.out.println (" to be $" + tempPainting.algorithmPrice + ".");
			System.out.println ();

			System.out.print ("Do you want to purchase this painting (Y/N)? ");

			try
			{
				ch=getChar();
			}
			catch (Exception e)
			{
				System.out.println ("***** Error: buyOther *****");
				System.out.println ("\t" + e);
			}

			if ((ch == 'Y') || (ch == 'y'))
			{
				getPurchaseInformation (tempPainting);
				addNewRecord (tempPainting);
			}
		}
		else
		{
			System.out.print ("\nThe algorithm has suggested");
			System.out.println (" that you should not buy this painting.");
		}

	} // buyOther

//----------------------------------------------------------------------------------------------------------------------------------------------------

	public void updateFashionability ()
	//
	// updateFashionability allows user to update constant fashionability coefficient
	//
	{
		try
		{

			clearScreen ();
			System.out.print ("This prototype uses a single fashionability coefficient");
			System.out.println (" for all artists.");
			System.out.print ("The final implementation must maintain coefficients");
			System.out.println (" for each artist.");
			System.out.println ();

			System.out.println ("The current value of the fashionability coefficient is: " + fash);
			System.out.print ("Please enter the new value for the coefficient: ");
			Float tempFloat = new Float (readString());
			fash = tempFloat.floatValue ();

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: updateFashionability *****");
			System.out.println ("\t" + e);
		}

	} // updateFashionability

//----------------------------------------------------------------------------------------------------------------------------------------------------

	public void buyPaintingMenu ()
	//
	// buyPaintingMenu allows user to select type of painting to be purchased
	//
	{
		boolean				done;
		char          choice;

		done = false;
		while (!done)
		{
			clearScreen ();
			System.out.println ("\t          BUY PAINTING MENU");
			System.out.println ("\t  Osbert Oglesby - Collector of Fine Art\n");
			System.out.println ("\t    1. Buy a Masterpiece");
			System.out.println ("\t    2. Buy a Masterwork");
			System.out.println ("\t    3. Buy an Other piece of work");
			System.out.println ("\t    4. Update Fashionability Coefficient");
			System.out.println ("\t    5. Return to Main Menu\n");
			System.out.print ("  Enter your choice and press <ENTER>: ");

			try
			{
				choice=getChar();

				switch (choice)
				{
					case '1':
						buyMasterpiece ();
						break;

					case '2':
						buyMasterwork ();
						break;

					case '3':
						buyOther ();
						break;

					case '4':
						updateFashionability ();
						break;

					case '5':
						done = true;
						break;

					default:
						System.out.println ("\n\nChoice is out of range\n");
						System.out.println ("    Press <ENTER> to return to menu...");
						pressEnter();
						break;
				}
			}
			catch (Exception e)
			{
				System.out.println ("***** Error: buyPaintingMenu *****");
				System.out.println ("\t" + e);
			}
		}

	} // buyPaintingMenu

//----------------------------------------------------------------------------------------------------------------------------------------------------

	public void sellPainting ()
	//
	// sellPainting allows user to sell a painting in the gallery
	//
	{
		try
		{

			int		      	i;
			boolean		  	found;
			String				firstName;
			String				lastName;
			String				title;

			clearScreen ();

			System.out.println ("\n\nPlease enter the following information describing the painting:");

			System.out.print ("Enter the FIRST name of the artist: ");
			firstName = readString();

			System.out.print ("Enter the LAST name of the artist: ");
			lastName = readString();

			System.out.print ("Enter the TITLE of the painting: ");
			title = readString();

			found = false;

			for (i = 0; i < galleryCount; i++)
			{
				if ((galleryRecords[i].description.firstName.compareTo (firstName) == 0) &&
					(galleryRecords[i].description.lastName.compareTo (lastName) == 0) &&
					(galleryRecords[i].description.title.compareTo (title) == 0))

				{
					found = true;
					break;
				}
			}

			if (found)
			{
				if (galleryRecords[i].sellPrice > 0)
          {
					System.out.print ("\n\nThe painting you described has already been sold!\n");
          }
				else
				{
					System.out.println ("\n\nPlease enter the following sale information: \n\n");

					galleryRecords[i].saleDate = new Date ();

					System.out.print ("Enter the NAME of the buyer: ");
					galleryRecords[i].buyerName = readString();

					System.out.print ("Enter the ADDRESS of the buyer: ");
					galleryRecords[i].buyerAddress = readString();

					System.out.print ("Enter the selling PRICE: ");
					Float tempFloat = new Float (readString());
					galleryRecords[i].sellPrice = tempFloat.floatValue ();

					System.out.println ("\n\nThe sale has been recorded.");
				}
			}
			else
			{
				System.out.println ("\n\nThe painting you described cannot be found in the gallery.");
				System.out.println ("Please make sure you entered the above information correctly.");
				System.out.println ("Proper case is required.");

				System.out.println ("\n\n    Press <ENTER> to continue");
				pressEnter();
			}

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: sellPainting *****");
			System.out.println ("\t" + e);
		}

	} // sellPainting

//----------------------------------------------------------------------------------------------------------------------------------------------------

	public void boughtReport ()
	//
	// boughtReport displays report of paintings bought
	//
	{
		try
		{
			int				i;
			float				totalPurchase;
			float				totalMax;
      SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");      

			totalPurchase = (float) 0.0;
			totalMax = (float) 0.0;

			clearScreen ();

			for (i = 0; i < galleryCount; i++)
			{
				if (((i % 3) == 0) && (i != 0))
				{
					System.out.println ();
					System.out.println ();
					System.out.println ("  Press <ENTER> to view the next screen...");
					pressEnter();
				}

				if ((i % 3) == 0)
				{
					clearScreen ();
					System.out.println ();
					System.out.println ();
					System.out.println ("                    Osbert Oglesby - Collector of Fine Art");
					System.out.println ("                              BOUGHT PAINTINGS\n");
				}

				System.out.println ("-------------------------------------------------------------------");

				System.out.print ("CLASSIFICATION: ");
				if (galleryRecords[i].purchasePrice > galleryRecords[i].algorithmPrice)
					System.out.print ("*");
				System.out.print (galleryRecords[i].classification + "  ");

				System.out.println ("\tPURCHASE DATE: " + dateFormat.format(galleryRecords[i].purchaseDate));

				System.out.print ("LAST NAME:      " + galleryRecords[i].description.lastName);
				System.out.println ("\t\tTITLE:        " + galleryRecords[i].description.title);

				System.out.print ("SUGG. PRICE:  " + galleryRecords[i].algorithmPrice);
				System.out.println ("\t\tPURCHASE PRICE: " + galleryRecords[i].purchasePrice);

				totalPurchase = totalPurchase + galleryRecords[i].purchasePrice;
				totalMax = totalMax + galleryRecords[i].algorithmPrice;
			}

			if (totalMax > 0)
				System.out.println ("\n\nAverage ratio: " + (totalPurchase / totalMax));
			else
				System.out.println ("There are no paintings in the gallery.");

			System.out.println ();
			System.out.println ();
			System.out.println ("	Press <ENTER> to continue");
			pressEnter();

		}
		catch (Exception e)
		{
			System.out.println ("***** Error: boughtReport *****");
			System.out.println ("\t" + e);
		}

	} // boughtReport

//----------------------------------------------------------------------------------------------------------------------------------------------------

	public void reportMenu ()
	//
	// reportMenu allows user to select type of report to be displayed
	//
	{
		boolean				done;
		char          choice;

		done = false;
		while (!done)
		{
			clearScreen ();
			System.out.println ("                          REPORT MENU");
			System.out.println ("          Osbert Oglesby - Collector of Fine Art\n");
			System.out.println ("                1.  Report on Bought Paintings");
			System.out.println ("                2.  Report on Sold Paintings");
			System.out.println ("                3.  Report on Fashion Trends");
			System.out.println ("                4.  Return to Main Menu");
			System.out.print ("          Enter your choice and press <ENTER>: ");

			try
			{
				choice=getChar();

				switch (choice)
				{
					case '1':
						boughtReport ();
						break;

					case '2':
						clearScreen ();
						System.out.println ("\t\t                REPORT ON SOLD PAINTINGS\n\n");
						System.out.print ("\t\t    This report is not implemented");
						System.out.println (" in the prototype\n\n\n");

						System.out.println ("      Press <ENTER> to return to the menu...");
						pressEnter();
						break;

					case '3':
						clearScreen ();
						System.out.println ("\t\t               REPORT ON CURRENT FASHIONS\n\n");
						System.out.print ("\t\t    This report is not implemented");
						System.out.println (" in the prototype\n\n\n");

						System.out.println ("      Press <ENTER> to return to the menu...");
						pressEnter();
						break;

					case '4':
						done = true;
						break;

					default:
						System.out.println ("\n\nChoice is out of range\n\n");
						System.out.println ("    Press <ENTER> to return to menu...");
						pressEnter();
						break;
				}
			}
			catch (Exception e)
			{
				System.out.println ("***** Error: reportMenu *****");
				System.out.println ("\t" + e);
			}
		}

	} // reportMenu

//----------------------------------------------------------------------------------------------------------------------------------------------------

	public void mainMenu ()
	//
	// mainMenu displays main menu containing all the options available to user
	//
	{
		boolean				done;
	  char					choice;

		done = false;
		while (!done)
		{
			clearScreen ();
			System.out.println ("\t        MAIN MENU");
			System.out.println ("\t  Osbert Oglesby - Collector of Fine Art\n");
			System.out.println ("\t    1.  Buy a Painting");
			System.out.println ("\t    2.  Sell a Painting");
			System.out.println ("\t    3.  Produce a Report");
			System.out.println ("\t    4.  Quit");
			System.out.print ("\t  Enter your choice and press <ENTER>: ");

			try
			{
				choice=getChar();

				switch (choice)
				{
					case '1':
						buyPaintingMenu ();
						break;

					case '2':
						sellPainting ();
						break;

					case '3':
						reportMenu ();
						break;

					case '4':
						done = true;
						break;

					default:
						System.out.println ("\n\nChoice is out of range\n\n");
						System.out.println ("      Press <ENTER> to return to menu...");
						pressEnter();
						break;
				}
			}
			catch (Exception e)
			{
				System.out.println ("***** Error: mainMenu *****");
				System.out.println ("\t" + e);
			}
		}

	} // mainMenu

} // class OsbertPrototype



class OsbertPrototypeApplication
{
	public static void main (String args[])
	{
		OsbertPrototype		op = new OsbertPrototype ();

		op.initializeClass ();

		op.mainMenu ();
	} // main
} // class OsbertPrototypeAplication
