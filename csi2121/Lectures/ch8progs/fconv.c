
#include <stdio.h>
#include <stdlib.h>

int main()
{
 float A, B, C, D ;

 printf("Enter the value for A:" );
 scanf("%f", &A);

 printf("Enter the value for B:" );
 scanf("%f", &B);

 printf("Enter the value for C:" );
 scanf("%f", &C);

 D = A*A + B*B + C*C ;
 printf("%g squared + %g squared + %g squared = %g", A, B, C, D) ;

 return 0;
}
