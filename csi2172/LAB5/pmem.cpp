#include <iostream.h>


// A is a class with
//     foo0: class function (NOT MEMBER FUNCTION)
//     foo1: pure virtual member function
//     foo2: NOT virtual member function
//
class A {
  public:
     static int foo0();
     virtual void foo1() const = 0;
     int foo2(const char*);
};


// B: public A is a class with
//     foo1: overridden from A
//
class B: public A {
  public:
     virtual void foo1() const;
};

int A::foo2(const char*) {
   cout << "A::foo2" << endl;
   return 4;
}

int A::foo0() {
   cout << "A::foo" << endl;
   return 3;
}


void B::foo1() const {
   cout << "B::foo1" << endl;
}

// class C is a paramtric class
// YOU DO NOT HAVE TO WORRY ABOUT
// THIS NOW, WAIT UNTIL WE
// COVER TEMPLATES
template<class T>
class C {
  public:
     C() { }
     int foo() const;
};

template<class T>
int C<T>::foo() const {
   cout << "C<T>::foo" << endl;
   return 8;
}

int main() {

    // p0 is a pointer to a function
    // which returns an int and takes
    // no arguments
    //
    // A::foo0 is such a function because
    // it is NOT a member but a class function
    int (*p0)() = A::foo0;

    A* a = new B;
    B  b;

    // p1 is a pointer to a MEMBER FUNCTION of A
    // which returns no value and takes no arguments
    // and is declared const
    //
    // A::foo1 is such a member, EVEN THOUGH it
    // is pure virtual or in other words it
    // must come from a subclass!
    void (A::* p1)() const = &(A::foo1); 

    // p2 is a pointer to a MEMBER FUNCTION of B (AND NOT A)
    // which returns no value and takes no arguments
    // and is declared const
    //
    // b.foo1 is such a MEMBER FUNCTION

    // APPARENTLY BORLAND DOES NOT LIKE THIS
    #if defined(_GNU_G_)
    void (B::* p2)() const = &(b.foo1);
    #else
    // SO WE DO ...
    void (B::* p2)() const = &(B::foo1);
    #endif

    // p3 is a pointer to a MEMBER FUNCTION of A
    // which returns an int and takes a const char*
    // as an argument
    //
    // a's foo2 is such a MEMBER FUNCTION, even though
    // a must point to a subclass of A, as class A is
    // abstract

    // APPARENTLY BORLAND DOES NOT LIKE THIS
    #if defined(_GNU_G_)
    int (A::* p3)(const char*) = &(a->foo2);
    #else
    // SO WE DO ...
    int (A::* p3)(const char*) = &(A::foo2);
    #endif

    // calling the method pointed to by p1 on a
    cout << "(a->*p1)(): ";
    (a->*p1)();

    // calling the method pointed to by p1 on b
    cout << "(b.*p1)(): ";
    (b.*p1)();

    // calling the method pointed to by p2 on b
    cout << "(b.*p2)(): ";
    (b.*p2)();

    // calling the method pointed to by p3 on b
    cout << "(b.*p3)(\"hello\"): ";
    (b.*p3)("hello");

    // calling the method pointed to by p3 on a
    cout << "(a->*p3)(\"hello\"): ";
    (a->*p3)("hello");

    // calling the function pointed to by p0 
    cout << "p0(): ";
    p0();


    // THE FOLLOWING ARE POINTERS TO TEMPLATE
    // FUNCTIONS, WAIT UNTIL WE COVER TEMPLATES
    C<int> c1;
    C<char*> c2;

    int (C<int>::* tp1)() const = &(C<int>::foo);
    int (C<char*>::* tp2)() const = &(C<char*>::foo);

    cout << "(c1.*tp1)(): ";
    (c1.*tp1)();

    cout << "(c2.*tp2)(): ";
    (c2.*tp2)();

 
    return 0;
}

      
