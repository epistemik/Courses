
/* find_btr.c

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
 #define RECORD_SIZE 310
 #define KEYS_PER_RECORD 8


 int main(int argc, char *argv[])
 {
  int wordcount,        /* index of current word to search for */
		recordcount,		/* # of records checked for the current word */
		keycount,			/* # of keys checked in the current record */
		index,				/* value of pointer in a record */
		Move,					/* Boolean indicating if need to go to a new record */
		Position,			/* value from strcmp() of key and word */
		Found ;				/* Boolean to indicate if current word was found */

  unsigned char *key[WORD_SIZE] ;   /* current term read in from the file */

  FILE *searchfile ;    /* file pointer */

  /* at least 3 command line args: 'find_btr', words, searchfile */
  if ( argc >= 3 )
	 {
	  if ( !(searchfile = fopen(argv[argc-1], "r")) )
		 {
		  fprintf(stderr, "Error: unable to open file '%s' for reading. \n\n", argv[argc-1] ) ;
		  exit(1) ;   /* if open fails for the file  */
		 }
	 }
  else  /* bad command line syntax */
	  {
		fprintf(stderr, "\n-> Command line should have: find_btr  word1 [word2...]  <file name> \n\n" ) ;
		exit(2);
	  }

  /* process each search word on the command line */
  for ( wordcount = 1; wordcount < (argc-1); wordcount++ )
  {
	Found = FALSE ;     	/* initialize Found to FALSE for each word */
	index = 1 ;				/* initialize index for each word */
	recordcount = 0 ;    /* initial record count is zero */

	/* as long as current key not found and we are not at a leaf node */
	while ( !Found && index != 0 )
	  {
		recordcount++ ;	/* increment record count */
		keycount = 0 ;    /* initialize key count to zero for this record */
		Move = FALSE ;    /* initialize Move to FALSE for this record */

		/* as long as current key not found, haven't found a key greater */
		/* than our search term, and keys remain in the record */
		while ( !Found && !Move && keycount < KEYS_PER_RECORD )
			{
			 /* get the pointer value and key */
			 fscanf(searchfile, "%d %s", &index, key) ;
			 /* set Booleans Position, Found, and Move */
			 Position = strcmp(argv[wordcount], key) ;
			 Found = ( Position == 0 ) ;
			 Move = ( Position < 0 ) ;
			 /* increment the key count */
			 keycount++ ;
			} /* endwhile-inner */

		if ( !Found && !Move )
			 /* if word was not found and the last key was less than the */
			 /* search term, then get the last pointer in the record */
			 fscanf(searchfile, "%d", &index) ;

		if ( index != 0 )
			 /* if not at a leaf, go to the next record */
			 fseek(searchfile, (index-1)*RECORD_SIZE, SEEK_SET)  ;
	  } /* endwhile-outer */

	/* Print out the results */
	if ( Found )
		fprintf(stdout, "I searched through %d records and then I found %s. \n", recordcount, key ) ;
	else
		 fprintf(stdout, "I searched through %d records but I never found %s. \n", recordcount, argv[wordcount] ) ;

	/* go back to the beginning of the file for the next word */
	rewind(searchfile) ;
	}	/* endfor */

  fclose(searchfile) ;
  return 0 ;
}	/* main() */

