
#include <stdio.h>

int f1(short int, short int, int, int);

int main()
{
   short int a=2, b=3;
   int c=4, d=5, z;
	
   z = f1(a, b, c, d);
   printf("result = %d\n", z);
   return 0;
}

int f1(short int a, short int b, int c, int d)
{
   return (a*a + b*b)/(c+d);
}
