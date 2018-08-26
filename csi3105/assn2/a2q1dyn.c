/* a2q1dyn.c
	Mark Sattolo  428500
	CSI-3105  Assignment 2
	The maximum contiguous sum problem is as follows:  Given an array X of
	n integers, find the maximum sum found in any contiguous subarray of X. */

#include <stdio.h>
#include <stdlib.h>

// function prototypes
int maxsum(int, int, int*, int*) ;
int max2(int, int) ;
int max3(int, int, int) ;
void printarray(int*, int) ;

int main(int argc, char* argv[])
{
 int i, L, U , sum, steps = 0,
	  *X ;

 if (argc < 2)
	{printf("  >> Usage: %s listitem1 listitem2 ... \n", argv[0]);
	 exit(EXIT_FAILURE);}

 L = 0 ;        // index to the lowest element in the array
 U = argc - 2 ; // U is the index of the last element in array X

 X = (int*) malloc((U+1) * sizeof(int));
 if (X == NULL)
	 {
	  puts("  >> Memory allocation failed! ");
	  exit(EXIT_FAILURE);
	 }
 // fill array X with the values from the command line
 for (i=0; i <= U; i++)
	 X[i] = atoi(argv[i+1]) ;

 printf("\n There are %d items in the list. \n", U+1) ;
 printf("\n The ") ;
 printarray(X, U) ;

 sum = maxsum(L, U, X, &steps) ;  // call the recursive procedure

 printf("\n The sum of the largest sub-array is %d. \n", sum) ;
 printf("\n The number of steps is %d. \n", steps) ;
 return EXIT_SUCCESS ;
} //main()

 int maxsum(int L, int U, int* X, int* s)
	{
	 int i, mid, sum,
		  maxToLeft, maxToRight, maxCrossing,
		  maxInA, maxInB ;

	 // base cases
	 if (L > U) return 0 ;
	 if (L == U)
		{
		 (*s)++ ;
		 return max2(0, X[L]) ;
		}

	 mid = (L + U) / 2 ;

	 // find the max sequence going left from the midpoint
	 sum = maxToLeft = 0 ;
	 for (i = mid; i >= L; i--)
		{
		 sum = sum + X[i] ;
		 maxToLeft = max2(maxToLeft, sum) ;
		 *s = *s + 2 ;
		}

	 // find the max sequence going right from the midpoint
	 sum = maxToRight = 0 ;
	 for (i = mid+1; i <= U; i++)
		{
		 sum = sum + X[i] ;
		 maxToRight = max2(maxToRight, sum) ;
		 *s = *s + 2 ;
		}

	 // find the max sequence through the midpoint of the array
	 maxCrossing = maxToLeft + maxToRight ;
	 (*s)++ ;

	 // find the max sequence in the left half of the array
	 maxInA = maxsum(L, mid, X, s) ;
	 // find the max sequence in the right half of the array
	 maxInB = maxsum(mid+1, U, X, s) ;

	 // find the overall maximum sub-sequence in the array
	 (*s)++ ;
	 return max3(maxCrossing, maxInA, maxInB) ;

	} //maxsum()

 int max2(int one, int two)
  {
	if (one > two) return one ;
	return two ;
  }

 int max3(int one, int two, int three)
  {
	if (one > two)
	  if (one > three) return one ;
	if (two > three) return two ;
	return three ;
  }

 void printarray(int* arr, int N)
  {
	int i ;
	printf("array is [") ;
	for (i = 0; i < N; i++)
		printf("%d, ", arr[i]) ;
	printf("%d]\n", arr[N]) ;
  }
