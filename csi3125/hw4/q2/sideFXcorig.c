
/* sideFXc.C */
/* Mark Sattolo  428500 */
/* CSI-3125, HW4, Q2 */

#include <stdio.h>

/* FUNCTION  PROTOTYPES */

	 int add1(int*) ;
	 int subtract2(int*) ;
	 int doubleX(int*) ;
	 int triple(int*) ;

/*********************** MAIN *******************************/

void main()
 {
  int X, Z ;
  puts("Mark Sattolo 428500, CSI3125, DGD-2, Homework#4") ;
  do
	 {
	  printf("\n Enter the input parameter: ") ;
	  scanf("%d",&X) ;
	  Z = triple(&X) + subtract2(&X) + add1(&X) * doubleX(&X) * X ;
	  printf("Output value is: %d \n", Z) ;
	  printf("Input value now is: %d \n", X) ;
	 }
  while (X < 3994) ;
 }

/******************* FUNCTION DEFINITIONS **************************/

  int add1(int* param)
	 {
	  (*param)++ ;
	  return *param ;
	 };//add1()

  int subtract2(int* param)
	 {
	  *param = (*param) - 2 ;
	  return param ;
	 };//subtract2()

  int doubleX(int* param)
	 {
	  *param = (*param) * 2 ;
	  return param ;
	 };//doubleX()

  int triple(int* param)
	 {
	  *param = (*param) * 3 ;
	  return param ;
	 };//triple()

/*********** END OF PROGRAM ************************************/
