/* crap.c
 Mark Sattolo  428500
 CSI-2131B
 Professor: Ken Barker
 Tutorial Group: Z
 TA: William Elazmeh
 Assignment 3	*/

 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>

 #define FALSE 0
 #define TRUE 1
 #define DICT_CAPACITY 256
 #define STRING_SIZE 32

 /* function prototypes */
 unsigned char reduce(unsigned char) ;
 int find(unsigned char*, unsigned char d[][STRING_SIZE], int) ;


int main(int argc, char *argv[])
 {
  int filecount,        /* # of files to crap */
		file_OK,		      /* boolean to check if files opened properly */
		dictsize = 64,		/* index of next empty dictionary slot */
		Kpos,					/* position of K in the dictionary 		*/
		Wcode ;				/* code for string W		    */

  unsigned char *nullbyte = "",		/* to write \0 */
					 W[STRING_SIZE],		/* working string */
					 inK,                /* initial input character */
					 Kchar,              /* reduced K */
					 K[2] = "",          /* string version of K for string fxn.s */
					 WK[STRING_SIZE] = "" ;   		/* concatenation of W and K */

  FILE *readfile, *crapfile ;    /*  file pointers  */

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

  /* at least 3 command line args: 'crap', output file, input files */
  if ( argc >= 3 )
	 {
	  if ( !(crapfile = fopen(argv[1], "wb")) )
		 {
		  fprintf(stderr, "Error: unable to open file '%s' for writing. \n\n", argv[1] ) ;
		  exit(1) ;     /* if open fails for the output file  */
		 }
	 }
  else   /* bad command line syntax */
	  {
		fprintf(stderr, "\n -> Command line should have: crap  <outputfile> <inputfile1> <inputfile2> <inputfile...> \n\n" ) ;
		exit(2);
	  }

  /* process each input file on the command line */
  for (filecount = 2; filecount < argc; filecount++)
  {
  if ( readfile = fopen(argv[filecount], "r") )
	  file_OK = TRUE ;   /* input file opened properly */
  else
	 { /* this input file did not open properly */
	  fprintf(stderr, "/nError: unable to open file '%s'! \n", argv[filecount] ) ;
	  fprintf(stderr, "File '%s' will not be archived in file '%s'. \n", argv[filecount], argv[1] ) ;
	  fprintf(stderr, "Processing will continue with other requested files. \n" ) ;
	  file_OK = FALSE ;
	  /* readfile not OK -- the rest of the for loop will not be processed */
	 }

  if (file_OK)
	{
	 /* write '\0,filename,\0' to output file */
	 fwrite(nullbyte, sizeof(char), 1, crapfile) ;
	 fwrite(argv[filecount], sizeof(char), strlen(argv[filecount]), crapfile) ;
	 fwrite(nullbyte, sizeof(char), 1, crapfile) ;

	 strcpy(W, "") ;		/* W set to empty string */
	 Wcode = 0 ;        /* clear Wcode */
	}

  while ( file_OK && ( fscanf(readfile, "%c", &inK) > 0) )
  /* if file opened and as long as we have a valid char and are not at EOF */
	 {
	 if (inK == '<')
		 /* loop through all chars until reach '>' */
		 while ( (fscanf(readfile, "%c", &inK) > 0) && (inK != '>') ) ;
	 else
		{
		 Kchar = reduce(inK) ;	/* reduce the character */
		 K[0] = Kchar ;         /* convert char to string */
		 strcpy(WK, W) ;        /* copy W into WK */
		 strcat(WK, K) ;        /* add K to the end of WK */

		 Kpos = find(WK, dict, dictsize) ;
		 /* if WK is in the dictionary*/
		 if (Kpos >= 0)
			{
			 strcat(W, K) ;      /* set W to K */
			 Wcode = Kpos ;      /* set Wcode to K's index */
			}
		 else  /* WK not in the dictionary */
			{
			 /* write W's code to output file */
			 fwrite(&Wcode, sizeof(char), 1, crapfile) ;
				  /* check that dictionary isn't full and WK is not too long */
			 if ( dictsize < DICT_CAPACITY && strlen(WK) < STRING_SIZE )
				{
				 strcpy(dict[dictsize], WK) ;  /* put WK in dictionary */
				 dictsize++ ;         /* increment to next free dictionary slot */
				}
			 strcpy(W, K) ;          /* set W to K */
			 Wcode = find(K, dict, dictsize) ;  /* set W's code to K's position */
			} /* endelse Kpos >= 0 */

		} /* endelse inK == '<'  */

	 } /* endwhile */

	 if (file_OK)
		{
		 fwrite(&Wcode, sizeof(char), 1, crapfile) ;  /* write out W's code */
		 fclose(readfile) ;
		}

  } /* endfor */

  fclose(crapfile) ;

  return(0) ;
} /* main() */


 /* alphabetics to upper case and ascii > 64 to space */
 unsigned char reduce(unsigned char big)
	{
	 unsigned char small ;
	 if ( big >= 'a' && big <= 'z')
		small = big - 32 ;
		else if ( big > 'z' )
		  small = ' ' ;
		  else
			 small = big ;
	 return small ;
	}

 /* get the dictionary index of a string or return -1 */
 int find(unsigned char* string, unsigned char dict[][STRING_SIZE], int size)
	{
	 int pos ;
	 for (pos = 0; pos < size; pos++)
		if ( strcmp(dict[pos], string) == 0 )
			return pos ;
	 return -1 ;
	}

