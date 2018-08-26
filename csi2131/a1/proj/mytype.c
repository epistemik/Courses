/*
 FILE: mytype.c

 Mark Sattolo  428500
 CSI-2131B
 Professor: Ken Barker
 Tutorial: Z
 T.A.: William Elazmeh

 Assignment 1
*/

#include <stdio.h>
#include <stdlib.h>   /* needed for exit() */

#define BINCHARSPERLINE 80

/* COMPILED WITH ANSI COMPLIANCE */

main( int argc, char *argv[] )
{
 /* assign the needed variables */
 FILE *testfile, *ascifile, *binfile ;
 unsigned char uchar ;
 int ascibool, count ;

 /* check the command line parameters */
 if( argc < 2 )
  {
	printf( "\nUsage: %s <filename> \n\n", argv[0] ) ;
	exit(1) ;
  }

 /* open the file named on the command line and verify that it opened properly */
 testfile = fopen(argv[1], "rb") ;   /* read-only binary mode */
 if (testfile == 0)
  {
	printf( "Unable to open file %s \n\n", argv[1] ) ;
	exit(2) ;
  }

/* variable ascibool will determine if file is text or binary
	- default set to 1 for 'true'     */
 ascibool = 1 ;
 while( fread(&uchar, 1, 1, testfile) == 1 )
	{
	 /*check for non-text character codes    */
	 if( uchar < 9 || uchar == 11 || uchar == 255 ||(uchar > 13 && uchar < 32) )
	  {
		ascibool = 0 ;
		break ;
		 /* set ascibool to false and leave loop if a non-text char is found */
	  }
	}
 fclose( testfile ) ;  /* close the file */

 if( ascibool == 1 ) /* it is an ascii text file */
  {
	/* reopen in ascii mode and verify  */
	ascifile = fopen( argv[1], "r" );
	if( ascifile == 0 )
	  {
		printf( "Unable to open file %s \n\n", argv[1] ) ;
		exit(3) ;
	  }

	while( fread(&uchar, 1, 1, ascifile) == 1 )
	  putchar(uchar) ; /* display the characters  */

	fclose( ascifile ) ;  /* close the file          */
  }
 else /* it is a binary file            */
	{
	 /* reopen in binary mode and verify  */
	 binfile = fopen( argv[1], "rb" );
	 if( binfile == 0 )
		{
		 printf( "Unable to open file %s \n\n", argv[1] ) ;
		 exit(4) ;
		}

	 count = 0 ; /* variable to keep track of the # of chars per line  */
	 while( fread(&uchar, 1, 1, binfile) == 1 )
		{
		 if( uchar >= 32 && uchar <= 254 )
			putchar(uchar) ; /* these are displayable chars       */
		 else
			  putchar('.') ;   /* put '.' for non-displayables    */

		 count++ ;          /* increment count        */
		 if( count == (BINCHARSPERLINE-1) )
		  {
			putchar( '\n' ) ; /* new line if we have reached BINCHARSPERLINE chars */
			count = 0 ;       /* reset count */
		  }
		}
	 fclose( binfile );  /* close the file   */

	}/* else binary */

  return 0 ;
}
/*  main()  */

