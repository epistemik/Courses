
/* a2q5rand.c
	Mark Sattolo  428500
	CSI-3105  Assignment 2
	The maximum contiguous sum problem is as follows:  Given an array X of
	n integers, find the maximum sum found in any contiguous subarray of X. */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define TRUE 1
#define FALSE 0

// function prototypes
void printarray(int*, int) ;
int findP(int, int*, int, int, int) ;

int main(int argc, char* argv[])
{
 int i, target, n, factor, *intArray ;

 // the default array
 char* paramList[] = {"argv[0]", "13", "24"} ;

 // if no command line parameters, give the format and use the default array
 if (argc != 3)
	 {
	  printf("\n  >> Command line format:\n\n\t ' %s  #elements  target-value ' \n", argv[0]) ;
	  argv = paramList ;
	 }

 target = atoi(argv[2]) ;   // set the target value
 n = atoi(argv[1]) - 1 ;  // n is the index of the last element in the array

 intArray = (int*) malloc( (n+1) * sizeof(int) ) ;
 if (intArray == NULL)
	 {
	  puts("Memory allocation failed. Goodbye.") ;
	  exit(EXIT_FAILURE) ;
	 }

 factor = 1 + (target/n) ; //set a step value for building the array
 srand((unsigned int) time(0)) ; // randomize rand()
 // fill intArray with random sorted values
 intArray[0] = (int) ( rand() % factor ) ;
 for (i=1; i <= n; i++)
	 intArray[i] = intArray[i-1] + 1 + ((int) ( rand() % factor )) ;

 printf("\n n = %d. \n", n+1) ;
 printf("\n target = %d. \n", target) ;
 printf("\n factor = %d. \n", factor) ;
 printf("\n The ") ;
 printarray(intArray, n) ;

 if ( findP(target, intArray, n+1, 0, n) )
	 printf("\n There IS a pair of numbers whose product is %d. \n", target) ;
 else
	 printf("\n There is NO pair of numbers whose product is %d. \n", target) ;

 return 0 ;
} //main()

// find if the array contains two numbers whose product is P
int findP(int P, int* Sarray, int length, int i, int n)
 {
  int k ;

  if (length <= 1) return FALSE ; // array has less than two numbers

  k = Sarray[i] * Sarray[n] ;  // find product of first and last numbers

  if (k == P) return TRUE ;  // two numbers have been found

  // else, eliminate the highest or lowest value of the array and search again
  if (k < P)
	  return findP(P, Sarray, length-1, i+1, n) ;
  else
	  return findP(P, Sarray, length-1, i, n-1) ;
 } //findP()


 void printarray(int* arr, int n)
 {
  int i ;
  printf("array is [") ;
  for (i=0; i<=n-1; i++)
		printf("%d, ", arr[i]) ;
  printf("%d]\n", arr[n]) ;
 } //printarray()

