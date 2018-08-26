
/* a2q1DYNrev.c
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
	  *Xarray ;
 // the default array
 char* paramList[] = {"argv[0]", "31", "-41", "59", "26", "-53", "58", "97", "-93", "-23", "84"} ;

 // if no command line parameters, give the format and use the default array
 if (argc < 2)
	 {
	  printf("\n  >> Command line format:\n\n\t ' %s listitem1 listitem2 ... ' \n", argv[0]) ;
	  argc = 11 ;
	  argv = paramList ;
	 }

 L = 0 ;
 U = argc - 2 ;  // U is the index of the last element in X

 // dynamically allocate space for Xarray
 Xarray = (int*) malloc((U+1) * sizeof(int)) ;
 if (Xarray == NULL)
	 {
	  puts("  >> Memory allocation failed! ") ;
	  exit(EXIT_FAILURE) ;
	 }
 // fill Xarray with the values from the command line
 for (i=0; i <= U; i++)
	 Xarray[i] = atoi(argv[i+1]) ;

 printf("\n There are %d items in the list. \n", U+1) ;
 printf("\n The ") ;
 printarray(Xarray, U) ;

 sum = maxsum(L, U, Xarray, &steps) ;

 printf("\n The sum of the largest sub-array is %d. \n", sum) ;
 printf("\n The number of steps is %d. \n", steps) ;
 return EXIT_SUCCESS ;
} //main()

 int maxsum(int L, int U, int* Xarray, int* step)
	{
	 int i, mid, sum,
		  maxToLeft, maxToRight, maxCrossing,
		  maxInA, maxInB ;

	 // find the value for the base cases
	 if (L > U) return 0 ;
	 if (L == U)
		{
		 (*step)++ ;
		 return max2(0, Xarray[L]) ;
		}

	 // set the mid-point index of the array
	 mid = (L + U) / 2 ;

	 // find the max sum to the left of the mid-point
	 sum = maxToLeft = 0 ;
	 for (i = mid; i >= L; i--)
		{
		 sum = sum + Xarray[i] ;
		 maxToLeft = max2(maxToLeft, sum) ;
		 *step = *step + 2 ;
		}

	 // find the max sum to the right of the mid-point
	 sum = maxToRight = 0 ;
	 for (i = mid+1; i <= U; i++)
		{
		 sum = sum + Xarray[i] ;
		 maxToRight = max2(maxToRight, sum) ;
		 *step = *step + 2 ;
		}

	 // find the max value that spans the left and right arrays
	 maxCrossing = maxToLeft + maxToRight ;
	 (*step)++ ;

	 // find the max span within the left sub-array
	 maxInA = maxsum(L, mid, Xarray, step) ;
	 // find the max span within the right sub-array
	 maxInB = maxsum(mid+1, U, Xarray, step) ;

	 // find the overall maximum value for a sub-array
	 (*step)++ ;
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

