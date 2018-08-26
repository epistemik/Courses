
/* [CSI 2131 Home]                                      CSI 2131 Tutorial #3

This week's tutorial is two C programs to help nail home the idea of binary
and ASCII files.

The first program, called b2x.c takes the name of a binary file from the
command line. It reads the file one byte at a time. For every byte in the
file, b2x displays a two-digit hexadecimal number corresponding to the
value of the byte read in. For example, if the binary file contains a byte
value 245, b2x will display the character 'F' followed by the character
'5'.

The second program, called x2b.c takes the name of an ASCII file from the
command line. It assumes that the file contains pairs of characters
corresponding to hexideximal values between '00' and 'FF'. x2b outputs a
value between 0 and 255 for each pair of characters in the input file.

  ------------------------------------------------------------------------

 b2x.c            */

 #include <stdio.h>                       /* function declarations, etc.     */
 #include <fcntl.h>
 #include <stdlib.h> //for exit()

int main(int argc, char *argv[])             /* argc = # of cmdline args        */
 {                                        /* argv = cmdline args             */
  int column = 0;                         /* inbyte must be int for getc     */
  unsigned char hich, loch, inbyte;
  FILE *infil;

  if(argc == 2)                           /* 2 cmdline args (1:b2x 2:infile) */
	  {                                    /* open cmdline arg for reading    */
		infil = fopen(argv[1], "rb");
		if(infil == 0)                      /* if open failed...               */
			{
			 fprintf(stderr, "Unable to open %s\n\n", argv[1]);
			 exit(1);
			}
	  }
  else                                    /* else: bad cmdline syntax        */
	  {
		fprintf(stderr, "Usage: b2x <inputfile>\n\n");
		exit(1);
	  }

  while(fread(&inbyte, 1, 1, infil) == 1) /* as long as we're not at EOF     */
	  {
		if(column > 68)                     /* if we already printed 70 cols   */
			{
			 column = 0;                     /* then start a new line           */
			 putchar('\n');
			}
														/* byte will be rep'd by 2 chars   */
		hich = (inbyte / 16);               /* the hi-order char               */
		if(hich > 9)
			hich += 'A' - 10;                /* calculate the ASCII code        */
		else
			hich += '0';

		loch = (inbyte % 16);               /* the hi-order char               */
		if(loch > 9)
			loch += 'A' - 10;                /* calculate the ASCII code        */
		else
			loch += '0';

		putchar(hich);                      /* print the chars to stdout       */
		putchar(loch);

		column += 2;                        /* we printed two chars            */
	  }

  fclose(infil);

  putchar('\n');                          /* extra new line, as required     */
  return 0;
 }

// (last update January 28, 2000)
