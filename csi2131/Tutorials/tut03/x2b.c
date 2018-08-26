
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

 x2b.c             */

 #include <stdio.h>
 #include <stdlib.h>                      /* function declarations, etc.     */

 int mytoupp(int); //function prototype

int main(int argc, char *argv[])             /* argc = # of cmdline args        */
 {                                        /* argv = cmdline args             */
  int ch1, ch2;                           /* each byte rep'd by two chars    */
  char outbyte;
  FILE *infil;

  if(argc == 2)                           /* 2 cmdline args (1:x2b 2:infile) */
     {
      infil = fopen(argv[1], "r");        /* open cmdline arg for reading    */
      if(!infil)                          /* if open failed...               */
         {
          fprintf(stderr, "Unable to open %s\n\n", argv[1]);
          exit(1);
         }
     }
  else                                    /* else: bad cmdline syntax        */
     {
      fprintf(stderr, "Usage: x2b <inputfile>\n\n");
      exit(1);
     }

  ch1 = mytoupp(getc(infil));             /* get the first char              */
  while(ch1 == '\n')                      /* skip over newline chars         */
     ch1 = mytoupp(getc(infil));
  ch2 = mytoupp(getc(infil));             /* get the second char             */
                                          /* (newline never b/w chars)       */
  while((ch1 != EOF) && (ch2 != EOF))     /* either char might've been EOF   */
     {
      if(ch1 >= '0' && ch1 <= '9')
			outbyte = (16 * (ch1 - '0'));    /* convert ch1 to hi-order bits    */
      else
         {
          if(ch1 >= 'A' && ch1 <= 'F')
             outbyte = (16 * (ch1 + 10 - 'A'));
			 else
             {
              fprintf(stderr, "Unexpected input... aborting.\n\n");
              fclose(infil);
              exit(2);
             }
         }

      if(ch2 >= '0' && ch2 <= '9')
         outbyte += (ch2 - '0');          /* convert ch2 to lo-order bits    */
      else
         {
          if(ch2 >= 'A' && ch2 <= 'F')
             outbyte += (ch2 + 10 - 'A');
          else
             {
              fprintf(stderr, "Unexpected input... aborting.\n\n");
              fclose(infil);
              exit(2);
             }
         }

      putchar(outbyte);                   /* print the binary byte to stdout */

      ch1 = mytoupp(getc(infil));         /* get the next two chars          */
      while(ch1 == '\n')
			ch1 = mytoupp(getc(infil));
      ch2 = mytoupp(getc(infil));
     }

  fclose(infil);
  return 0;
 } // main()

 int mytoupp(int ch)
 {
  return((ch >= 'a' && ch <= 'z') ? ch - ('a' - 'A') : ch);
 }

// (last update January 28, 2000)

