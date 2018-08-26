#include "types.h"
#include <iostream.h>
#include <string.h>

void (*f1)(); // definition of variable f1

void foo1() { 
   // definition of function foo1
   cout << "hello" << endl;
}


int (*f2)(const char*, char*&, bool = false);
   // definition of variable f2


int foo2(const char* a1, char*& a2, bool b) {
   // definition of function foo2
   // foo2 copies the reverse of string a1
   // into a2
   // if b is true than foo2 creates a new
   // array in a2, otherwise it assumes that
   // one already exists there 
   // foo2 returns the length of a1

   int l = strlen(a1);
   if (b) {
      a2 = new char[l+1];
   }

   for(int i=0; i<l; i++) {
      a2[i] = a1[l-i-1];
   }

   a2[l] = '\0';

   return l;
}

int (*f3)(int*, int, int (*) (int&));
   // definition of variable f3

int (*A[3])(int*, int, int (*) (int&));
   // definition of variable A 

