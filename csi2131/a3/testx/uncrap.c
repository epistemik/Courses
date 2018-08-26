
/* uncrap.c

 Mark Sattolo  428500
 CSI-2131B
 Professor: Ken Barker
 Tutorial Group: Z
 TA: William Elazmeh

 Assignment 3
*/

 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>

 #define FALSE 0
 #define TRUE 1
 #define DICT_CAPACITY 256
 #define STRING_SIZE 32
 #define MAX_FILE_NAME 255

 int main(int argc, char *argv[])
 {
  int WFopen = FALSE,      /* flag to keep track of the open writefile */
		count,            	/* counter for building file names */
		dictsize = 64 ;      /* index for next open dictionary slot */

  unsigned char
			W[STRING_SIZE] = "",       /* string used for the dict processing */
			FN[MAX_FILE_NAME] = "",		/* filename read from the crapfile */
			Kstring[2] = "",    			/* string version of K for string fxn.s  */
			Wstring[2] = "",				/* string version of W for string fxn.s  */
			K,                  			/* original character from the file	  */
			WK[2*STRING_SIZE] = "" ;   /* string of W and K concatenation  */

  FILE *writefile, *crapfile ;    	/*  file pointers  */

  unsigned char dict[DICT_CAPACITY][STRING_SIZE] = {
  "\0", "\n", " ", "!", "\"", "#", "$", "%",
  "&", "\'", "*", "+", ",", "-", ".", "/",
  "0", "1", "2", "3", "4", "5", "6", "7",
  "8", "9", ":", ";", "(", "=", ")", "?",
  "A", "B", "C", "D", "E", "F", "G", "H",
  "I", "J", "K", "L", "M", "N", "O", "P",
  "Q", "R", "S", "T", "U", "V", "W", "X",
  "Y", "Z", "[", "]", "\\", "^", "@", "_"
  };

  /* need 2 command line args: 'uncrap', input file */
  if ( argc == 2 )
	 {
	  if ( !(crapfile = fopen(argv[1], "rb")) )
		 {
		  fprintf(stderr, "Error: unable to read file '%s' \n\n", argv[1] ) ;
		  exit(1) ;     /* if open fails for the input file  */
		 }
	 }
  else   /* bad command line syntax */
	  {
		fprintf(stderr, "\n -> Error in input: Command line should have: uncrap <inputfile> \n\n" ) ;
		exit(2);
	  }

  while ( fscanf(crapfile, "%c", &K) > 0 )
  /* as long as we have a valid char and are not at EOF */
	 {
	 if (K == NULL)   /* we are at a new file */
		{
		if (WFopen) fclose(writefile) ; /* close the previous file */

		strncpy(FN, "", MAX_FILE_NAME) ;		/* clear FN */
		fscanf(crapfile, "%c", &K) ;  /* get next char */
		/* get the name of the output file */
		for (count = 0; count < MAX_FILE_NAME && K != NULL; count++)
			{
			 FN[count] = K ;
			 fscanf(crapfile, "%c", &K) ;
			}
			/* open the output file */
		if ( !(writefile = fopen(FN, "w")) )
		  {
			fprintf(stderr, "Error: unable to write to file '%s' \n\n", FN ) ;
			exit(3) ;     /* if open fails for the output file  */
		  }
		WFopen = TRUE ;  /* file is open */

		fscanf(crapfile, "%c", &K) ;    /* get next char */
		/* write out dictionary entry for the first code in the file */
		fwrite(dict[K], sizeof(char), strlen(dict[K]), writefile) ;
		strcpy(W, dict[K]) ;          /* copy the dictionary entry to W */
		fscanf(crapfile, "%c", &K) ;  /* get next char */
		} /* endif K == NULL */

		 /* if K is in the dictionary */
	 if ( K < dictsize )
		{
		 /* output the dictionary entry at index K */
		 fwrite(dict[K], sizeof(char), strlen(dict[K]), writefile) ;
		 strcpy(WK, W) ;               			/* copy W to WK */
		 Kstring[0] = dict[K][0] ;     			/* convert K to a string */
		 strncat(WK, Kstring, STRING_SIZE) ;	/* add K to end of WK */
		}
	 else /* K is not in the dictionary */
		{
		 strcpy(WK, W) ;         /* copy W to WK */
		 Wstring[0] = W[0] ;     /* convert W to a string */
		 strncat(WK, Wstring, STRING_SIZE) ;   /* add W to end of WK */
		 fwrite(WK, sizeof(char), strlen(WK), writefile) ;  /* write out WK */
		} /* endelse K < dictsize */

		 /* if room in dictionary and WK not too large */
	 if ( dictsize < DICT_CAPACITY && strlen(WK) < STRING_SIZE )
		{
		 strcpy(dict[dictsize], WK) ; 	/* add WK to dictionary */
		 dictsize++ ;
		}
	 /* copy dictionary entry at K to W */
	 strcpy(W, dict[K]) ;
	 }  /* endwhile */

  fclose(writefile) ;
  fclose(crapfile) ;

  return(0) ;
 } /* main() */

