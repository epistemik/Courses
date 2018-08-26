
/* crap.c

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


 /* function prototypes */
 unsigned char reduce(unsigned char) ;
 int find(unsigned char*, unsigned char d[][32], int) ;


 int main(int argc, char *argv[])
 {
  int filecount,
		dictsize = 64,
 /*		Kchar,				/* reduced character from the file 		*/
 /*		inK,				/* original character from the file		*/
		Kpos,				/* position of K in the dictionary 		*/
		Wcode ;			/* code for string W		    */

  unsigned char *nullbyte = "",
					 W[32],
					 inK,
					 Kchar,
					 K[2] = "",
					 WK[32] = "" ;   		/* strings */

  FILE *readfile, *crapfile ;    /*  file pointers  */

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

  /* at least 3 command line args: 'crap', output file, input files */
  if ( argc >= 3 )
	 {
	  if ( !(crapfile = fopen(argv[1], "wb")) )
		 {
		  fprintf(stderr, "Error: unable to open file '%s' \n\n", argv[1] ) ;
		  exit(1) ;     /* if open fails for the output file  */
		 }
	 }
  else   /* bad command line syntax */
	  {
		fprintf(stderr, "Command line should have: crap  <outputfile> <inputfile1> <inputfile2> <inputfile...> \n\n" ) ;
		exit(2);
	  }

  for (filecount = 2; filecount < argc; filecount++)
  {
  if ( !(readfile = fopen(argv[filecount], "r")) )
	 {
	  fprintf(stderr, "Error: unable to open file '%s' \n\n", argv[filecount] ) ;
	  exit(3) ;     /* if open fails for an input file  */
	 }

  fwrite(nullbyte, sizeof(char), 1, crapfile) ;
  fwrite(argv[filecount], sizeof(char), strlen(argv[filecount]), crapfile) ;
  fwrite(nullbyte, sizeof(char), 1, crapfile) ;
  /* need a function for all writes with error handling. */

  strcpy(W, "") ;  
  Wcode = 0 ;

  while ( fscanf(readfile, "%c", &inK) > 0 )
  /* as long as we have a valid char and are not at EOF */
	 {
	 if (inK == '<')
		{
 /*	 putchar(inK) ;	*/
		 while ( (fscanf(readfile, "%c", &inK) > 0) && (inK != '>') ) ;
		}
	 else
		{
 /*	putchar(inK) ;		*/
		Kchar = reduce(inK) ; /* check this cluster */
		K[0] = Kchar ;
		strcpy(WK, W) ;
		strcat(WK, K) ;

 /*	puts(dict[3]) ;
		puts(WK) ;		*/

		Kpos = find(WK, dict, dictsize) ;
		if (Kpos >= 0)
		  {
			strcat(W, K) ;
			Wcode = Kpos ;
		  }
		else
		  {
			fwrite(&Wcode, sizeof(char), 1, crapfile) ; /* error handling */
			if ( dictsize < 256 && strlen(WK) < 32 )
			  {
				strcpy(dict[dictsize], WK) ;
				dictsize++ ;
			  }
			strcpy(W, K) ;
			Wcode = find(K, dict, dictsize) ;
		  } /* else */

		} /*  inK != '<'  */

	 }  /* while */
	 fwrite(&Wcode, sizeof(char), 1, crapfile) ;  /* error handling */
	 fclose(readfile) ;  /* error handling */

  }  /* for */
  fclose(crapfile) ;   /* error handling */

  for (Kpos = 0; Kpos < dictsize; Kpos++)
	 printf(" dict[%d] is \"%s\"  \n", Kpos, dict[Kpos]) ;

  return(0) ;
 } /* main() */


 unsigned char reduce(unsigned char big)
	{
	 unsigned char small ;
	 if ( big >= 'a' && big <= 'z')
		small = big - 32 ;
	 else if ( big > 'z' )
		small = ' ' ;
		else
		  small = big;
	 return small ;
	}

 int find(unsigned char* string, unsigned char dict[][32], int size)
	{
	 int pos ;
	 for (pos = 0; pos < size; pos++)
		{
  /*	puts(dict[pos]) ;
		puts(string) ;		*/
		if ( strcmp(dict[pos], string) == 0 )
			return pos ;
		}
	 return -1 ;
	}

