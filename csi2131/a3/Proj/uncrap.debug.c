
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


 /* function prototype */
 int find(unsigned char*, unsigned char d[][32], int) ;


 int main(int argc, char *argv[])
 {
  int WFopen = 0,       /* flag to keep track of the open writefile */
		count,            /* counter for building file names */
		dictsize = 64 ;

  unsigned char W[32] = "",         /* string used for the dict processing */
					 FN[256] = "",       /* filename read from the crapfile */
					 Kstring[2] = "",    /* string version of K for string fxn.s  */
					 Wstring[2] = "",		/* string version of W for string fxn.s  */
					 K,                  /* original character from the file	  */
					 WK[32] = "" ;   	 	/* string of W and K concatenation  */

  FILE *writefile, *crapfile ;    /*  file pointers  */

  unsigned char dict[256][32] = {
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
		  fprintf(stderr, "Error: unable to open file '%s' \n\n", argv[1] ) ;
		  exit(1) ;     /* if open fails for the input file  */
		 }
	 }
  else   /* bad command line syntax */
	  {
		fprintf(stderr, "Command line should have: uncrap  <inputfile> \n\n" ) ;
		exit(2);
	  }

  while ( fscanf(crapfile, "%c", &K) > 0 )
  /* as long as we have a valid char and are not at EOF */
	 {
	 if (K == NULL)
		{
		if (WFopen) fclose(writefile) ;

		fscanf(crapfile, "%c", &K) ;
		for (count = 0; count < 256 && K != NULL; count++)
			{
			 FN[count] = K ;
			 fscanf(crapfile, "%c", &K) ;
			}

		if ( !(writefile = fopen(FN, "w")) )
		  {
			fprintf(stderr, "Error: unable to open file '%s' \n\n", FN ) ;
			exit(3) ;     /* if open fails for the output file  */
		  }
		WFopen = 1 ;

		fscanf(crapfile, "%c", &K) ;
		fwrite(dict[K], sizeof(char), strlen(dict[K]), writefile) ;  /* error handling */
		strcpy(W, dict[K]) ;
		fscanf(crapfile, "%c", &K) ;
		} /* endif K == NULL */

	 if ( K < dictsize )
		{
		 fwrite(dict[K], sizeof(char), strlen(dict[K]), writefile) ;  /* error handling */
		 strcpy(WK, W) ;
		 Kstring[0] = dict[K][0] ;
		 strncat(WK, Kstring, 32) ;
		}
	 else
		{
		 strcpy(WK, W) ;
		 Wstring[0] = W[0] ;
		 strncat(WK, Wstring, 32) ;
		 fwrite(WK, sizeof(char), strlen(WK), writefile) ;  /* error handling */
		} /* endif K in the dictionary */

	 if ( dictsize < 256 && strlen(WK) < 32 )
		{
		 strcpy(dict[dictsize], WK) ;
		 dictsize++ ;
		} /* add WK to dictionary */

	 strcpy(W, dict[K]) ;
	 }  /* end of while loop */

  fclose(writefile) ;  /* error handling */
  fclose(crapfile) ;   /* error handling */

  /* DEBUGGING */
  for (count = 0; count < dictsize; count++)
	 printf(" dict[%d] is \"%s\"  \n", count, dict[count]) ;

  return(0) ;
 } /* main() */


 int find(unsigned char* string, unsigned char dict[][32], int size)
	{
	 int pos ;
	 printf("\n\n SIZE: %d \n", size) ;
	 for (pos = 0; pos < size; pos++)
		{
		 printf("pos: %d \n", pos) ;
		 printf("string: %s \n", string) ;
		 printf("dict[%d]: %s \n", pos, dict[pos]) ;
		 if ( strcmp(dict[pos], string) == 0 )
			return pos ;
		}
	 return -1 ;
	}

