#include "types.h"
#include <iostream.h>


static int apply1(int* a, int l, int (*f)(int&)) {
    // definition of a "local to this file" or
    // "static" function of type F3 (type declared in
    // "types.h"

    // apply1 takes an array of integers of length
    // l and applies f on each and every element of a

    // apply1 returns l

    for(int i=0; i<l; i++) {
       f(a[i]);
    }

    return l;
}


static int apply2(int* a, int l, int (*f)(int&)) {
     // apply2 is similar to apply1, but
     // it returns 
     //
     //      l-1
     // s =  SUM  f(a[i])
     //      i=0
    

    int s = 0;

    for(int i=0; i<l; i++) {
       s+= f(a[i]);
    }

    return s;
} 

static int identity(int& i) {
   // returns itself
   return i;
}

static int square1(int& i) {
   // returns i^2
   return i*i;
}

static int square2(int& i) {
   // first MODIFIES i to be i*i
   // and returns this value
   return i = i*i;
}

static int print(int& i) {
   // prints i on the screen
   // and returns i
   cout << i << ' ';
   return i;
}

int main() {

    f1 = foo1;
    f1();

   
    char *greetings = "hello world!", *backwards;; 

    f2 = foo2;

    f2(greetings,backwards,true);
    cout << greetings << endl
         << backwards << endl;


    f2(backwards,backwards);

    cout << backwards << endl; // how did this happen?

    delete [] backwards;  // why do I have to delete this?

   
    A[0] = apply1;  // A[0] points to apply1
    A[1] = 0;       // A[1] does not point to a function
    A[2] = apply2;  // A[2] points to apply2

    int array[] = {1,2,3,4,5,6,7,8,9,10};


    cout << "The array initially: ";

    A[0](array,10,print);
    cout << endl;

    cout << "Sum of elements: " << A[2](array,10,identity) << endl;
    cout << "Sum of elements squared: " << A[2](array,10,square1) << endl;
    cout << "The array now: ";
    A[0](array,10,print);
    cout << endl;

    A[0](array,10,square2);
    cout << "The array now: ";
    A[0](array,10,print);
    cout << endl;

    return 0;
} 


