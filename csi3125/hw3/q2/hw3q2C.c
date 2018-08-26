
#include <stdio.h>
#define a 13
#define b 27
#define c 20+5
#define d a+2*b

main()
{
 printf("%d\n", c);
 //c = 27 ; Lvalue required in function main
 printf("%d\n", d);
 printf("%d\n", 3*d);
 return 0 ;
}
