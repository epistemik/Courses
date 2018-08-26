
/* Mark Sattolo  428500 
   CSI-3125, DGD-2 
   HW4, Q2           */

#include <stdio.h>

/* FUNCTION  PROTOTYPES */

	 int add1(int*) ;
	 int subtract2(int*) ;
	 int double_(int*) ;
	 int triple(int*) ;

/*********************** MAIN *******************************/

int main(void)
 {
  int X, Y, W, Z ;
  /* identification */
  puts("Mark Sattolo 428500, CSI3125, DGD-2, Homework#4 \n") ;
  /* Get a maximum value for calculating the expression */
  puts("We will calculate from X = 1 to a maximum value.") ;
  printf("Enter a maximum integer value for the loop: ") ;
  /* we can assume the input will be OK */
  scanf("%d", &Y) ;
  /*start the loop*/
  for (W = 1; W <= Y; W++)
	 {
	  /* put the value to be calculated into X */
	  X = W ;
	  /* print out the initial value */
	  printf("\n >> Starting input value was: %d \n", X) ;
	  /* evaluate the expression */
	  Z = triple(&X) + subtract2(&X) + add1(&X) * double_(&X) * X ;
	  /* print out the final values */
	  printf(" >> Output value is: %d \n", Z) ;
	  printf(" >> Input value now is: %d \n", X) ;
	 }
  puts("\n\t PROGRAM ENDED.") ;
  return 0 ;
 }

/************* FUNCTION DEFINITIONS ****************
 Each function will print out that it has been called
 and will give the new value of X inside that function.  */

  int add1(int* param)
	 {
	  puts("Inside add1.") ;
	  (*param)++ ;
	  printf("Value of X is now: %d. \n", *param) ;
	  return *param ;
	 };//add1()

  int subtract2(int* param)
	 {
	  puts("Inside subtract2.") ;
	  *param = (*param) - 2 ;
	  printf("Value of X is now: %d. \n", *param) ;
	  return *param ;
	 };//subtract2()

  int double_(int* param)
	 {
	  puts("Inside double_.") ;
	  *param = (*param) * 2 ;
	  printf("Value of X is now: %d. \n", *param) ;
	  return *param ;
	 };//double_()

  int triple(int* param)
	 {
	  puts("Inside triple.") ;
	  *param = (*param) * 3 ;
	  printf("Value of X is now: %d. \n", *param) ;
	  return *param ;
	 };//triple()

/************** END OF PROGRAM **********************/
