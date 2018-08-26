/* CSI 2131 Tutorial #5

This week's tutorial is (surprise!) two C programs. The first program writes
integers to a binary file. The second program reads in the integers written by
the first program and prints them to the screen. So what's the big deal?
The integers are 12-bit integers!
To write 12-bit integers to a file, you have to write them two at a time, taking
up 3 bytes. The hi-order 8 bits of the first 12-bit integer go in the first
byte. The lo-order 4 bits of the first integer and the hi-order 4 bits of the
second integer go in the second byte. The lo-order 8 bits of the second integer
go in the third byte. Here's a little ASCII picture to help illustrate the idea.
Bits are numbered 0-23 (from right to left); bytes are written out as bits
16-23, then 8-15, then 0-7.

			 the first 12-bit integer           the second 12-bit integer
		_______________________________     _______________________________
	  /                               \   /                               \
	 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
	+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
	+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	  \___________________/   \___________________/   \___________________/
		first byte written      second byte written      third byte written

Isolating the different bits in each integer to stuff in the correct position in
each byte is of course done with mod and div as usual (as you'll see in the
programs).
The programs are called write12.c and read12.c. But first, here is the output
(below). The program write12.c writes two 12-bit integers at a time, twenty
times. The integers are 1000 2000, then 1001 2001, then 1002 2002, up to 1019
2019. The file it writes is called foo (naturally). By doing a b2x (see tutorial
#3) on foo after running write12, you can see the 12-bit integers: 3E8 7D0, 3E9
7D1, 3EA 7D2 all the way up to 3FB 7E3. Then read12 reads in the 12-bit integers
no problem and displays them to the screen.

C:\work>write12 foo

C:\work>b2x foo
3E87D03E97D13EA7D23EB7D33EC7D43ED7D53EE7D63EF7D73F07D83F17D93F27DA3F37
DB3F47DC3F57DD3F67DE3F77DF3F87E03F97E13FA7E23FB7E3

C:\work>read12 foo
num1 = 1000, num2 = 2000
num1 = 1001, num2 = 2001
num1 = 1002, num2 = 2002
num1 = 1003, num2 = 2003
num1 = 1004, num2 = 2004
num1 = 1005, num2 = 2005
num1 = 1006, num2 = 2006
num1 = 1007, num2 = 2007
num1 = 1008, num2 = 2008
num1 = 1009, num2 = 2009
num1 = 1010, num2 = 2010
num1 = 1011, num2 = 2011
num1 = 1012, num2 = 2012
num1 = 1013, num2 = 2013
num1 = 1014, num2 = 2014
num1 = 1015, num2 = 2015
num1 = 1016, num2 = 2016
num1 = 1017, num2 = 2017
num1 = 1018, num2 = 2018
num1 = 1019, num2 = 2019

One last thing:
  Writing two 12-bit integers as 3 bytes means that there is a problem if you
  want to write an odd number of integers.
  How do you think the programs should handle this situation?


Program 2: read12.c */

#include <stdio.h>
#include <stdlib.h>

/* read12 will read three bytes from a file and return them as  */
/* 12-bit numbers (returns 1 on success, zero on failure)       */

// PROTOTYPE
int read12(FILE*, unsigned*, unsigned*);

// MAIN //////////////////////////////////////////////////
int main(int argc, char *argv[])
{
 FILE *myFile;
 unsigned num1, num2; // 32 bits

 if( argc == 2 )  /* the usual stuff for opening a file for binary reading */
	 {
	  if( !(myFile = fopen(argv[1], "rb")) ) // read binary
		  {
			fprintf(stderr, "Unable to open %s for reading! \n\n", argv[1]);
			exit(2);
		  }
	 }
 else
	 {
	  fprintf(stderr, "Usage: read12 <infile> \n\n");
	  exit(1);
	 }

 printf("Size of num1, num2 (unsigned) is %d bits. \n\n", 8*sizeof(unsigned) ) ;

 while( read12(myFile, &num1, &num2) != 0 )
	 printf("num1 = %d, num2 = %d \n", num1, num2);

 fclose(myFile);
 return 0 ;
}
// main()

int read12(FILE *infil, unsigned *number1, unsigned *number2)
{
 unsigned char hi8, lo4hi4, lo8; // e.g. 3E, 87, D0

 if( fread(&hi8, 1, 1, infil) != 1 )
	return(0);
 if( fread(&lo4hi4, 1, 1, infil) != 1 )
	return(0);
 if( fread(&lo8, 1, 1, infil) != 1 )
	return(0);

 *number1 = hi8 * 0x10;                 /* move hi8 4 bits left = 3E0         */
 *number1 = *number1 + (lo4hi4 / 0x10); /* add hi 4 bits of middle byte = 3E8 */
 *number2 = (lo4hi4 % 0x10) * 0x0100;   /* move lo 4 bits of middle byte
															8 bits to the left = 700         */
 *number2 = *number2 + lo8;             /* add lo byte = 7D0   */

 return(1);
}
// read12()
