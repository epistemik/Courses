
/* mytype.c

  File for assignment 1

*/

#include <stdio.h>

main(int argc, char *argv[])
{
 FILE *testfile, *ascifile, *binfile ;
 unsigned char uchar ;
 int ascibool, count ;

 testfile = fopen(argv[1], "r") ;
 if (!testfile)
    {
     printf( "Unable to open file %s \n\n", argv[1] ) ;
     exit(1) ;
    }

 ascibool = 1 ;
 while( (uchar = getc(testfile)) != EOF )
    {
    if ( uchar < 9 || uchar == 11 || (uchar > 13 && uchar < 32) )
        {
        ascibool = 0 ;
        break ;
        }
    }
 fclose(testfile) ;


 if (ascibool) // ascii file
  {
  ascifile = fopen(argv[1], "r");
  if (!ascifile)
     {
     printf( "Unable to open file %s \n\n", argv[1] ) ;
     exit(1) ;
     }

  count = 0 ;
  while ( (uchar = getc(ascifile)) != EOF )
    {
    putchar(uchar) ;
    count++ ;
    if(count == 60)
        {
        putchar('\n') ;
        count == 1 ;
        }
     }
  fclose(ascifile) ;
  } // if ascii file


 else // binary file
  {
  binfile = fopen(argv[1], "rb");
  if (!binfile)
     {
     printf( "Unable to open file %s \n\n", argv[1] ) ;
     exit(1) ;
     }

 count = 0 ;
 while ( (uchar = getc(binfile)) != EOF )
    {
    if ( uchar < 9 || uchar == 11 || (uchar > 13 && uchar < 32) )
        putchar('.') ;
    else
        putchar('\0' + uchar) ;
    count++ ;
    if(count == 60)
        {
        putchar('\n') ;
        count == 1 ;
        }
     }
  fclose(binfile);
  } // else binary file

} //main()

