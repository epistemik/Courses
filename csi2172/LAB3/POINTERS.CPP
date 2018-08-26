// File pointers.cpp

#include <iostream.h>

#define POINTER void*	// we use this to force the printout in "address" format, 
								// it is only a cast
int a = 5,
	*pa = &a,
	**ppa = &pa,
	b = 3;

void show()
{
   cout << "a = " << a << endl
        << "&a = " << (POINTER)&a << endl
        << "b = " << b << endl
        << "&b = " << (POINTER)&b << endl
        << "pa = " << (POINTER)pa << endl
        << "&pa = " << (POINTER)&pa << endl
        << "*pa = " << *pa << endl
        << "ppa = " << (POINTER)ppa << endl
        << "&ppa = " << (POINTER)&ppa << endl
        << "*ppa = " << (POINTER)*ppa << endl
        << "&(*ppa)= " << (POINTER)&(*ppa) << endl
        << "*(&(*ppa))= " << (POINTER)*(&(*ppa)) << endl
        << "**ppa= " << **ppa << endl << endl;
 }

int main()
{
   cout << "initially:" << endl;
   show();

   pa = &b;
   cout << "after pa = &b: " << endl;
   show();

   **ppa = 8; 
   cout << "after **ppa = 8: " << endl;
   show();

   *ppa = &a;
   cout << "after *ppa = &a: " << endl;
   show();
   
   return 0; 
}
