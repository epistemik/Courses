#if !defined(_TYPES_H_)
#define _TYPES_H_



extern void (*f1)();
       // f1 is a pointer to a function which takes
       // no arguments and returns no value
       // IT IS A VARIABLE! f1 is EXTERN hence
       // it has to be defined somewhere

typedef void (*F1)();
       // F1 is a TYPE, which is a pointer to a
       // function which takes no arguments and
       // returns no value
      
void foo1();
       // foo1 is a FUNCTION which takes no
       // arguments and returns no value
       // hence f1 can point to foo1 and
       // foo1 is also of type F1


extern int (*f2)(const char*, char*&, bool = false);
       // f2 is a pointer to a function which
       // takes the following parameters:
       //    - a character string by const
       //    - a character string by reference
       //    - an optional boolean with default value false
       // the function pointed to by f2 returns an int

typedef int (*F2)(const char*, char*&, bool = false);
       // F2 is a TYPE and can point to any function
       // whose prototype is describes for variable f2

int foo2(const char*, char*&, bool = false);
       // foo2 is a function of type F2




extern int (*f3)(int*, int, int (*) (int&));
       // f3 is a pointer to a function which takes
       // the following parameters:
       //     - a pointer to an int (which could be an array!)
       //     - an int
       //     - a function which returns an int and
       //       and takes an int by reference
       // the function pointed to by f3 returns an int
   
typedef int (*F3)(int*, int, int (*) (int&));
       // F3 is a TYPE and can point to any function
       // whose prototype is describes for variable f3


extern int (*A[3])(int*, int, int (*) (int&));
       // A is an ARRAY of three functions of type F3

#endif
