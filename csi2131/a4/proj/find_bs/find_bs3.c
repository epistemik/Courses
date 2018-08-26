
/* find_bs.c

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
 #define WORD_SIZE 256
 #define RECORD_SIZE 37


 int main(int argc, char *argv[])
 {
  int wordcount,        	/* index of current word to search for */
		recordcount,			/* # of records checked for the current word */
		number_of_records,   /**/
		Position,				/**/
		Found ;					/* Boolean to indicate if current word was found */

  long int file_length,       /**/
			  startpoint,			/**/
			  midpoint,				/**/
			  endpoint ;			/**/

  unsigned char *key[WORD_SIZE] ;	 /* current term read in from the file */

  FILE *searchfile ;    /* file pointer */

  /* at least 3 command line args: 'find_bs', words, searchfile */
  if ( argc >= 3 )
	 {
	  if ( !(searchfile = fopen(argv[argc-1], "r")) )
		 {
		  fprintf(stderr, "Error: unable to open file '%s' for reading. \n\n", argv[argc-1] ) ;
		  exit(1) ;     /* if open fails for the file  */
		 }
	 }
  else   /* bad command line syntax */
	  {
		fprintf(stderr, "\n-> Command line should have: find_seq  word1 [word2...]  <file name> \n\n" ) ;
		exit(2);
	  }

  if ( fseek(searchfile, 0, SEEK_END) != 0 )
	 {
	  fprintf(stderr, "File I/O error: unable to seek in file '%s'. \n", argv[argc-1]) ;
	  exit(3) ;
	 }
  file_length = ftell(searchfile) ;

  if ( file_length < 0 )
	 {
	  fprintf(stderr, "File I/O error: invalid length for file '%s'. \n", argv[argc-1]) ;
	  exit(4) ;
	 }
  number_of_records = file_length / RECORD_SIZE ;

  /* process each search word on the command line */
  for ( wordcount = 1; wordcount < (argc-1); wordcount++ )
  {
	midpoint = number_of_records / 2 ;
	startpoint = 0 ;
	endpoint = number_of_records+1 ;
	Found = FALSE ;     	/* initialize Found to FALSE for each word */
	recordcount = 0 ;    /* initial record count is zero */

	while ( !Found && (startpoint < midpoint) )
	/* as long as current key not found and records remain in the search interval */
	  {
		/* increment record count */
		recordcount++ ;
		if ( fseek(searchfile, (midpoint-1)*RECORD_SIZE, SEEK_SET) != 0 )
			{
			 fprintf(stderr, "File I/O error: unable to seek in file '%s'. \n", argv[argc-1]) ;
			 exit(5) ;
			}
		if ( fscanf(searchfile, "%s", key) > 0 )
			{ /* compare the strings and store result in Position */
			 Position = strcmp(argv[wordcount], key) ;
//			 fprintf(stdout, "midpoint is %d \n", midpoint);
//			 fprintf(stdout, "key is %s \n", key);
//			 fprintf(stdout, "Record # is %d \n\n", recordcount);
			}
		else
			{
			 fprintf(stderr, "File I/O error: unable to scan in file '%s'. \n", argv[argc-1]) ;
			 exit(6) ;
			}
		Found = ( Position == 0 ) ;
		if ( Position < 0 )
			endpoint = midpoint ;
		else
			startpoint = midpoint ;
		midpoint = (startpoint + endpoint) / 2 ;

	  }  /* endwhile */

	/* Print out the results */
	if ( Found )
		fprintf(stdout, "I searched through %d records and then I found %s. \n", recordcount, key ) ;
	else
		 fprintf(stdout, "I searched through %d records but I never found %s. \n", recordcount, argv[wordcount] ) ;

	}	/* endfor */

  fclose(searchfile) ;
  return 0 ;
}	/* main() */

