
/* a2q3.c
	Mark Sattolo  428500
	CSI-3103  Assignment 2 */

#include <stdio.h>
#include <math.h>

#define ber 5e-6         // bit error rate
#define channel 1e7      // channel capacity
#define prop_delay 0.1   // propagation delay

int main(void)
{
 double trans_time,  // time to transmit a message of length L
		  A,           // prop_delay (Tp) divided by trans_time (Tix)
		  maxA,
		  Pf,          // the frame error rate - based on the bit error rate (ber)
		  maxPf,
		  L,           // the length of a frame, in bits
		  maxL,
		  U,           // Utilization rate of the channel
		  maxU ;

 puts("\n CSI-3103, Assignment 2, Question 3: ") ;
 puts(" Find the maximum channel utilization U for a range of values of frame length L. \n") ;

 maxL = maxU = maxA = maxPf = 0.0 ;  // initialization of the max values

 for (L = 1000.0; L <= 1e6; L = L + 1.0)
	{
	 // calculate new values for the parameters based on the current value of L
	 trans_time = L / channel ;
	 A = prop_delay / trans_time ;
	 Pf = 1.0 - ( pow((1.0 - ber), L) ) ;
	 U = (1.0 - Pf) / (2.0*A + 1.0) ;

	 // set new max values if necessary
	 if (U > maxU)
		{
		 maxU = U ;
		 maxL = L ;
		 maxPf = Pf ;
		 maxA = A ;
		}
	}//endfor

 printf(" The maximum value of U is %lf \n", maxU) ;
 printf(" The value of L when U is maximal is %lf \n", maxL) ;
 printf(" The value of A when U is maximal is %lf \n", maxA) ;
 printf(" The value of Pf when U is maximal is %lf \n\n", maxPf) ;

 return 0 ;
} // main()

