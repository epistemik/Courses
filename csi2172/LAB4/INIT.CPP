#include <iostream.h>

class X {
   private:
     double x;
   public:
     // X has NO default constructor!!!
     X(double);

     double get_x() const;
};

class A {
   protected:
     int a;
     X x;

   public:
     // this can also be the default
     // constructor, as it can be
     // called with 0 arguments
     A(double = 3.14, int = 3);

     int get_a() const;
     double get_x() const;
};


class B: public A {
   private:
     int b;

   public:
      // again, this can also be a default
      // constructor
      B(int = 5, double = 2.72, int = 7);

      int get_b() const;
};


// here the initializer is used to
// assign d to x
X::X(double d):x(d) {
  cout << "X::X(double), x initilaized to " << d << endl;
}

double X::get_x() const {
   return x;
}


// here the initializer is used to
// assign i to a 
// AND it also calls X's constructor
// with d
//
// X has no default constructor! hence
// the initilizer MUST be used to
// invoke its only constructor X::X(double)
A::A(double d, int i):a(i),x(d) {
   cout << "A::A(double,int), a is initialized to " << i << endl;
   cout << "                , X::X is called with " << d << endl;
}

int A::get_a() const {
   return a;
}

double A::get_x() const {
   return x.get_x();
}

// here the initilizer is used to invoke A(double,int)
// with the appropriate parameters
// comment this code out and also run with the
// buggy version below
// 
// the initializer is the only place to invoke a 
// different constructor, other than the default!
//
B::B(int j, double d, int i):A(d,i),b(j) {
   cout << "B::B(int,double,int), b is initialized to " << j << endl;
}

/** 
// Buggy version!
B::B(int j, double d, int i):b(j) {
   a = i;
   x = d;
   cout << "B::B(int,double,int), a is initialized to " << i << endl;
   cout << "                    , X::X is called with " << d << endl;
   cout << "                    , b is initialized to " << j << endl;
}
**/  


int main() {

   B b(1,2,3);

   return 0;
}
 








     





     
   
