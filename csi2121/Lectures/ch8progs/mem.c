
#include <stdio.h>
#include <stdlib.h>

int f1(short int, short int, int, int);

int main()
{
   int a=1,b=2,c=3,d=4,e=5,f=6,g=7,h=8,i=9,j=10,k=11,l=12,m;
   int count;
   int z[25];
   int *y;
	
   for(count=0; count<25; count++)
   {
	z[count] = count;
   }
   
   y = (int *) calloc(25, sizeof(int));

   for(count=0; count<25; count++)
   {
	y[count] = count;
   }

   m=a+b+c+d+e+f+g+h+i+j+k+l;
   
   for(count=0; count<25; count++)
   {
	m += y[count]+z[count];
   }


   printf("m = %d\n", m);
   return 0;
}
