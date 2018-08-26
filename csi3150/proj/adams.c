/*
*   ADAMS-BASHFORTH 4-STEP ALGORITHM : see p.302
*   (ADAMS FOURTH-ORDER PREDICTOR-CORRECTOR ALGORITHM 5.4)
*
*   To approximate the solution of the initial value problem
*
*          y' = f(t,y), a <= t <= b, y(a) = alpha,
*
*   at N+1 equally spaced points in the interval [a,b].
*
*   INPUT:   endpoints a,b; initial condition alpha; integer N.
*
*   OUTPUT:  approximation w to y at the (N+1) values of t.
*/

#include<stdio.h>
#include<math.h>
#define true 1
#define false 0

/* PROTOTYPES */
double F( double, double );
void RK4( double, double, double, double*, double* );
void getInput( int*, double*, double*, double*, int* );
void chooseOutput( FILE** );

int main()
{
 double T[4], W[4] ;
 double A, B, ALPHA, H, T0, W0 ;
 int I, N, J, OK ;
 FILE *OUP ;

 getInput( &OK, &A, &B, &ALPHA, &N );

 if( OK )
  {
	chooseOutput( &OUP );

	/* STEP 1 */
	H = (B - A) / N ;
	T[0] = A ;
	W[0] = ALPHA ;
	fprintf( OUP, "%5.3f %11.6f \n", T[0], W[0] );

	/* STEP 2 */
	for( I=1; I <= 3; I++ )
	 {
	  /* STEPS 3 AND 4 */
	  /* compute starting values using Runge-Kutta method given in a subroutine */
	  RK4( H, T[I-1], W[I-1], &T[I], &W[I] );
	  fprintf( OUP, "%5.3f %11.6f \n", T[I], W[I] );
	  /* STEP 5 */
	 }
	/* STEP 6 */
	for( I=4; I <= N; I++ )
	 {
	  /* STEP 7 */
	  /* T0, W0 will be used in place of t, w resp. */
	  T0 = A + I * H ;
	  /* predict W(I) */
	  W0 = W[3] + H*( 55.0 * F(T[3],W[3]) - 59.0 * F(T[2],W[2])
							+ 37.0 * F(T[1],W[1]) - 9.0 * F(T[0],W[0]) )/24.0 ;
	  /* STEP 8 */
	  fprintf( OUP, "%5.3f %11.7f \n", T0, W0 );

	  /* STEP 9 */
	  /* prepare for next iteration */
	  for( J=1; J <= 3; J++ )
		{
		 T[J-1] = T[J] ;
		 W[J-1] = W[J] ;
		}
	  /* STEP 10 */
	  T[3] = T0 ;
	  W[3] = W0 ;
	 }
	/* STEP 11 */
	fclose( OUP );
  }
 return 0 ;
}
/* main() */


/*  Change function F for a new problem    */
double F( double T, double Y )
  {
	double f ;

	f = (Y*Y + Y)/T ;

	return f ;
  }
/* F() */


void RK4( double H, double T0, double W0, double *T1, double *W1 )
  {
	double K1, K2, K3, K4 ;

	*T1 = T0 + H ;
	K1 = H * F(T0, W0) ;
	K2 = H * F(T0 + 0.5*H, W0 + 0.5*K1) ;
	K3 = H * F(T0 + 0.5*H, W0 + 0.5*K2) ;
	K4 = H * F(*T1, W0 + K3) ;
	*W1 = W0 + (K1 + 2.0 * (K2 + K3) + K4) / 6.0 ;
  }
/* RK4() */


void getInput( int *OK, double *A, double *B, double *ALPHA, int *N )
  {
	char AA ;

	printf( "\n This is Adams-Bashforth 4-step Method. \n" );
	printf( "\n Has the desired function F been defined in the program? \n" );
	printf( "Enter Y or N: " );
	scanf( "%c", &AA );

	*OK = false;
	if( (AA == 'Y') || (AA == 'y') )
	 {
	  *OK = false ;
	  while( !(*OK) )
		{
		 printf( "\n Input left and right endpoints separated by blank. \n" );
		 scanf( "%lf %lf", A, B );
		 if( *A >= *B )
		  printf( "Left endpoint must be less than right endpoint! \n" );
		 else
			  *OK = true ;
		}
	  printf( "\n Input the initial condition [value of Y(%g)]: \n", *A );
	  scanf( "%lf", ALPHA );
	  *OK = false ;
	  while( !(*OK) )
		{
		 printf( "\n Input a positive integer for the number of subintervals. \n" );
		 scanf( "%d", N );
		 if( *N <= 0.0 )
			printf( "Number must be a positive integer! \n" );
		 else
			  *OK = true ;
		}
	 }
  else
	  {
		printf( "The program will end so that F can be created. \n" );
		*OK = false ;
	  }
}
/* INPUT() */


void chooseOutput( FILE **OUP )
  {
	char NAME[32] ;
	int FLAG ;

	printf( "\n Choice of output method: \n" );
	printf( "1. Output to screen \n" );
	printf( "2. Output to text file \n" );
	printf( "Please enter 1 or 2: " );

	scanf( "%d", &FLAG );
	if( FLAG == 2 )
	  {
		printf( "\n Input the file name in the form - drive:\dir\name.ext \n" );
		printf( "For example  A:\PROG\OUTPUT.DATA \n" );
		scanf( "%s", NAME );
		*OUP = fopen( NAME, "w" );
	  }
	else
		 *OUP = stdout ;

	fprintf( *OUP, "\n ADAMS-BASHFORTH 4-STEP METHOD \n\n" );
	fprintf( *OUP, "  t        w    \n" );
  }
/* chooseOutput() */
