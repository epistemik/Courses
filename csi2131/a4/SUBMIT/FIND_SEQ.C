
/* find_seq.c

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


 int main(int argc, char *argv[])
 {
  int wordcount,        /* index of current word to search for */
		recordcount,		/* # of records checked for the current word */
		Found ;				/* Boolean to indicate if current word was found */

  unsigned char *key[WORD_SIZE] ;	 /* current word read from the file */

  FILE *searchfile ;    /* file pointer */

  /* at least 3 command line args: 'find_seq', words, searchfile */
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

  /* process each search word on the command line */
  for (wordcount = 1; wordcount < (argc-1); wordcount++)
  {
	Found = FALSE ;     	/* initialize Found to FALSE for each word */
	recordcount = 0 ;    /* initial record count is zero */

	/* as long as current key not found, we have a valid string, and are not at EOF */
	while ( !Found && fscanf(searchfile, "%s", key) > 0 )
	  {
		/* increment record count */
		recordcount++ ;
		/* compare the strings and store result in Found */
		Found = ( strcmp(argv[wordcount], key) == 0 ) ;
	  } /* endwhile */

	/* Print out the results */
	if ( Found )
		fprintf(stdout, "I searched through %d records and then I found %s. \n", recordcount, key ) ;
	else
		 fprintf(stdout, "I searched through %d records but I never found %s. \n", recordcount, argv[wordcount] ) ;

	/* go back to the beginning of the file for the next word */
	rewind(searchfile) ;
	} /* endfor */

  fclose(searchfile) ;
  return 0 ;
}	/* main() */

