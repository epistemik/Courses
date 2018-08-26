/* find_bs.c
	- this version uses the binary search algorithm from the class notes

 Mark Sattolo  428500
 CSI-2131B
 Professor: Ken Barker
 Tutorial Group: Z
 TA: William Elazmeh

 Assignment 4
*/

 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>

 #define FALSE 0
 #define TRUE 1
 #define WORD_SIZE 255
 #define RECORD_SIZE 37


int main(int argc, char *argv[])
{
  int wordcount,        	/* index of current word to search for */
		recordcount,			/* # of records checked for the current word */
		number_of_records,   /* total # of records in the file */
		Position,				/* +ve or -ve value from strcmp of key and word */
		Found ;					/* Boolean to indicate if current word was found */

  long int file_length,       /* length of file in bytes */
			  startpoint,			/* starting record of search interval */
			  midpoint,				/* middle record of search interval */
			  endpoint ;			/* last record in search interval */

  unsigned char *key[WORD_SIZE] ;	 /* current word being searched for */

  FILE *searchfile ;    /* file pointer */

  /* at least 3 command line args: 'find_bs', words, searchfile */
  if ( argc >= 3 )
	 {
	  if ( !(searchfile = fopen(argv[argc-1], "r")) )
		 {
		  fprintf(stderr, "Error: unable to open file '%s' for reading.\n\n", argv[argc-1]);
		  exit(1) ;     /* if open fails for the file  */
		 }
	 }
  else   /* bad command line syntax */
	  {
		fprintf(stderr, "\nCommand line should have: find_bs word1 [word2...] <file name>\n\n");
		exit(2);
	  }

  /* go to the end of the file */
  if ( fseek(searchfile, 0, SEEK_END) != 0 )
	 {
	  fprintf(stderr, "File I/O error: unable to find EOF in file '%s'.\n", argv[argc-1]);
	  exit(3) ;
	 }
  /* record the file length in bytes */
  file_length = ftell(searchfile) ;

  /* check the file length */
  if ( file_length < RECORD_SIZE )
	 {
	  fprintf(stderr, "Error: invalid length for file '%s'. \n", argv[argc-1]) ;
	  exit(4) ;   /* need at least one complete record in a file */
	 }
  /* calculate the number of records in the file */
  number_of_records = file_length / RECORD_SIZE ;

  /* process each search word on the command line */
  for ( wordcount = 1; wordcount < (argc-1); wordcount++ )
  {
	/* initial start and end points */
	startpoint = 0 ;
	endpoint = number_of_records ;
	Found = FALSE ;     	/* initialize Found to FALSE for each word */
	recordcount = 0 ;    /* initial record count is zero */

	/* as long as current key not found and records remain in the search interval */
	while ( !Found && (endpoint >= startpoint) )
	  {
		/* calculate midpoint */
		midpoint = (startpoint + endpoint) / 2 ;
		/* increment record count */
		recordcount++ ;
		/* go to the middle of the current search interval */
		if ( fseek(searchfile, midpoint*RECORD_SIZE, SEEK_SET) != 0 )
			{
			 fprintf(stderr, "File I/O error: unable to seek in file '%s'.\n", argv[argc-1]);
			 exit(5) ;    /* error if couldn't reposition properly */
			}
		/* get the key */
		fscanf(searchfile, "%s", key) ;
		/* compare the search term to the key and store result in Position */
		Position = strcmp(key, argv[wordcount]) ;
		/* set Found */
		Found = ( Position == 0 ) ;

		/* reset start or end point depending on the previous search result */
		if ( Position < 0 )
			startpoint = midpoint + 1 ;
		else
			endpoint = midpoint - 1 ;
	  } /* endwhile */

	/* Print out the results */
	if ( Found )
		fprintf(stdout, "I searched through %d records and then I found %s.\n", recordcount, key);
	else
		 fprintf(stdout, "I searched through %d records but I never found %s.\n",
											 recordcount, 					argv[wordcount]  ) ;

	} /* endfor */

  fclose(searchfile) ;
  return 0 ;
}
/* main() */

