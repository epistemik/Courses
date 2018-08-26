
/* hw4q2.c */
/* Mark Sattolo  428500 */
/* CSI-3125, Homework4, Q2 */

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
  /*identification*/
  puts("Mark Sattolo 428500, CSI3125, DGD-2, Homework#4 \n") ;
  /*Get a maximum value for calculating the expression*/
  puts("We will calculate the expression for 2 to a maximum value.") ;
  printf("Enter the maximum input value for the loop: ") ;
  scanf("%d", &Y) ;
  /*start the loop*/
  for (X = 2; X <= Y; X++)
	 {
	  /*preserve the initial value of X*/
	  W = X ;
	  /*evaluate the expression*/
	  Z = triple(&X) + subtract2(&X) + add1(&X) * double_(&X) * X ;
	  /*print out the values*/
	  printf("\nStarting input value was: %d \n", W) ;
	  printf("Output value is: %d \n", Z) ;
	  printf("Input value now is: %d \n", X) ;
	  /*restore the proper value of X for the loop*/
	  X = W ;
	 }
  puts("\nPROGRAM ENDED.") ;
  return 0 ;
 }

/************* FUNCTION DEFINITIONS *****************/

  int add1(int* param)
	 {
	  (*param)++ ;
	  return *param ;
	 };//add1()

  int subtract2(int* param)
	 {
	  *param = (*param) - 2 ;
	  return *param ;
	 };//subtract2()

  int double_(int* param)
	 {
	  *param = (*param) * 2 ;
	  return *param ;
	 };//double_()

  int triple(int* param)
	 {
	  *param = (*param) * 3 ;
	  return *param ;
	 };//triple()

/************** END OF PROGRAM **********************/
