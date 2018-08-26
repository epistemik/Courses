/*
*    EULER'S ALGORITHM 5.1
*
*      TO APPROXIMATE THE SOLUTION OF THE INITIAL VALUE PROBLEM:
*
*				Y' = F(T,Y),  A <= T <= B,  Y(A) = ALPHA,
*
*      AT N+1 EQUALLY SPACED POINTS IN THE INTERVAL [A,B].
*
*      INPUT:  ENDPOINTS A, B; INITIAL CONDITION ALPHA; INTEGER N.
*
*      OUTPUT:  APPROXIMATION W TO Y AT THE (N+1) VALUES OF T.
*/

#include <stdio.h>
#include <math.h>

#define true 1
#define false 0

double F( double, double );
void INPUT( int*, double*, double*, double*, int* );
void OUTPUT( FILE** );

main()
{
  double A, B, ALPHA, H, T, W ;
  int I, N, OK ;
  FILE *OUP ;

  INPUT( &OK, &A, &B, &ALPHA, &N );
  if( OK )
	{
	  OUTPUT( &OUP );

	  /* STEP 1 */
	  H = (B - A) / N;
	  T = A;
	  W = ALPHA;
	  fprintf( OUP, "%5.3f %11.7f \n", T, W);

	  /* STEP 2 */
	  for( I=1; I<=N; I++ )
    {
			/* STEP 3 */
			/* COMPUTE W(I) */
			W = W + H * F(T, W);
			/* COMPUTE T(I) */
			T = A + I * H;
			/* STEP 4 */
			fprintf( OUP, "%5.3f %11.7f \n", T, W);
		}

		/* STEP 5 */
		fclose( OUP );
	}
	return 0;

}// main()


/*  Change function F for a new problem   */
double F( double T, double Y )
{
	double f ;

	f = T*Y ;

	return f ;
}


void INPUT( int *OK, double *A, double *B, double *ALPHA, int *N )
{
	char AA;

	printf("\n This is Euler's Method. \n\n");
	printf("Has the function F been defined? \n");
	printf("Enter Y or N. \n");
	scanf( "%c",&AA );

	*OK = false;
	if( (AA == 'Y') || (AA == 'y') )
  {
		*OK = false;
		while( !(*OK) )
    {
			printf("\n Input left and right endpoints separated by blank: \n");
			scanf( "%lf %lf", A, B );
			if( *A >= *B )
				printf("Left endpoint must be less than right endpoint! \n");
			else
          *OK = true;
		}

		printf("\n Input the initial condition [value of Y(%g)]: \n", *A);
		scanf( "%lf", ALPHA );
		*OK = false;
		while( !(*OK) )
    {
			printf("\n Input a positive integer for the number of subintervals: \n");
			scanf( "%d", N );
			if( *N <= 0.0 )
        printf("Number must be a positive integer! \n");
			else
          *OK = true;
		}
	}
	else
  		printf("The program will end so that the function can be created. \n");

}// INPUT()


void OUTPUT( FILE **OUP )
{
	char NAME[32];
	int FLAG;

	printf("\n Choice of output method: \n");
	printf("1. Output to screen \n");
	printf("2. Output to text file \n");
	printf("Please enter 1 or 2: \n");
	scanf( "%d", &FLAG );

	if( FLAG == 2 )
  {
		printf("Input the file name in the form - drive:name.ext \n");
		printf("For example  A:OUTPUT.DTA \n");
		scanf( "%s", NAME );
		*OUP = fopen( NAME, "w" );
	}
	else
      *OUP = stdout;

	fprintf( *OUP, "\n EULER'S METHOD\n\n" );
	fprintf( *OUP, "    t       w    \n\n" );

}// OUTPUT()
