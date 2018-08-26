
/* a1q5.c
	Mark Sattolo  428500
	CSI-3105  Assignment 1 */

#include <stdio.h>
#define SIZE 7

// function prototypes
void exchange(int*, int*) ;
void printarray(int*, int) ;

int main(void)
{
 int k = 10,
	  gt = 0,
	  n = SIZE - 1,
	  lte = n,
	  steps = 0 ,
	  i, j,
	  test[SIZE] = {4,40,5,2,11,9,10} ;

 printf("\n Initially, ") ;
 printarray(test, n) ;

 while ( gt < lte )
	{
	 i = 0 ;
	 /* increment steps for the first (or last) comparison in the loop,
		 i.e. for the time the comparison is false and the loop isn't entered */
	 steps++ ;
	 while ( (gt <= n) && (test[gt] <= k) )
		{
		 gt++ ;
		 i++ ;  // increment i for each comparison in the loop
		}
	 // increment steps by the number of times through the loop
	 steps = steps + i ;

	 j = 0 ;
	 /* increment steps for the first (or last) comparison in the loop,
		 i.e. for the time the comparison is false and the loop isn't entered */
	 steps++ ;
	 while ( (lte >= 0) && (test[lte] > k) )
		{
		 lte-- ;
		 j++ ;  // increment j for each comparison in the loop
		}
	 // increment steps by the number of times through the loop
	 steps = steps + j ;

	 if ( gt < lte )
	  {
		exchange(&test[gt], &test[lte]) ;
		gt++ ;
		lte-- ;
		steps = steps + 2 ;
	  }
	}

  printf("\n After the program, ") ;
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
  printf("%d]. \n", arr[n]) ;
 }

