
/* a1q5rand.c
	Mark Sattolo  428500
	CSI-3105  Assignment 1 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// function prototypes
void exchange(int*, int*) ;
void printarray(int*, int) ;

int main(int argc, char* argv[])
{
 int i, k, n, limit, right,
	  left = 0, steps = 0,
	  *test ;

 if (argc != 3)
	 {
	  printf("  >> Usage: %s #nodes limit" , argv[0]);
	  exit(EXIT_FAILURE);
	 }

 limit = atoi(argv[2]) ;
 srand((unsigned int) time(0)) ; // randomize rand()
 k = (int)(rand() % limit) ;  // k is random

 n = atoi(argv[1]) - 1 ;  // n is the index of the last element in test
 right = n ;

 test = (int*) malloc((n+1) * sizeof(int));
 if (test == NULL)
	 {
	  puts("Memory allocation failed. Goodbye.");
	  exit(EXIT_FAILURE);
	 }
 // fill array test with the values from the command line
 for (i=0; i <= n; i++)
	 test[i] = (int)(rand() % limit) ;

 printf("\n k = %d. \n", k) ;
 printf("\n n = %d. \n", n+1) ;
 printf("\n First, ") ;
 printarray(test, n) ;

 while ( left < right )
	{
	 /* increment steps for the first (or last) comparison in the loop,
		 i.e. for the time the comparison is false and the loop isn't entered */
	 steps++ ;
	 while ( (left <= n) && (test[left] <= k) )
		{
		 left++ ;
		 steps++ ;  // increment for each comparison in the loop
		}

	 /* increment steps for the first (or last) comparison in the loop,
		 i.e. for the time the comparison is false and the loop isn't entered */
	 steps++ ;
	 while ( (right >= 0) && (test[right] > k) )
		{
		 right-- ;
		 steps++ ;  // increment for each comparison in the loop
		}

	 if ( left < right )
	  {
		exchange(&test[left], &test[right]) ;
		left++ ;
		right-- ;
		steps = steps + 2 ;  // increment for each change of position
	  }
	}

  printf("\n After, ") ;
  printarray(test, n) ;
  printf("\n The total number of steps is %d. \n", steps) ;
  return 0;
}

void exchange(int* start, int* end)
 {
  int temp ;
  temp = *start ;
  *start = *end ;
  *end = temp ;
 }

void printarray(int* arr, int n)
 {
  int i ;
  printf("the array is [") ;
  for (i=0; i<=n-1; i++)
		printf("%d, ", arr[i]) ;
  printf("%d]\n", arr[n]) ;
 }

