
/* a1q3.c
	Mark Sattolo  428500
	CSI-3105  Assignment 1 */

#include <stdio.h>
#include <math.h>

int main(void)
{
 int n, steps, i, j, k, p, answer ;

 // (a)
 puts("\n PART A ") ;
 steps = 0 ;
 for (n=1; n<=10; n++)
	{
	 p = 5 ;
	 for (steps=0, i=1; i <= n-3; i++)
		 for (j = i; j <= n-1; j++)
			 {
			  p = p * 20 ;
			  steps++ ;
			 }
	 printf("\n n = %d and steps = %d", n, steps) ;
	}

 // (b)
 puts("\n\n PART B ") ;
 steps = 0 ;
 for (k=0; k<10; k++)
	{
	 n = (int) pow(2,k) ;
	 answer = 25;
	 for (steps=0, i=1; i <= n; i++)
		{
		 j = n ;
		 while (j >= 1)
			{
			 answer = answer * 5 ;
			 j = j/2 ; //rounded down
			 steps++ ;
			}
		}
	 printf("\n k = %d and n = %d and steps = %d", k, n, steps) ;
	}

 // (c)
 puts("\n\n PART C ") ;
 steps = 0 ;
 for (n=1; n<=10; n++)
	{
	 answer = 2 ;
	 for (steps=0, i = 1; i <= n; i++)
		 for (j = 1; j <= pow(i,2); j++)
			{
			 answer = answer * 7 ;
			 steps++ ;
			}
	 printf("\n n = %d and steps = %d", n, steps) ;
	}

 puts(" ") ;
 return 0 ;
} // main()

