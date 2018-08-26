// File:  inherit.cpp

#include <iostream.h>
#include "inher.h"

X::X() {
  cout << "X::X()" << endl;
}

X::X(int) {
  cout << "X::X(int)" << endl;
}

Y::Y() {
  cout << "Y::Y()" << endl;
}

Y::Y(int) {
  cout << "Y::Y(int)" << endl;
}

A::A():a(0) {
  cout << "A::A()" << endl;
  cout << "(a initialized)" << endl;
}

A::A(int i):a(i) {
  cout << "A::A(int)" << endl;
  cout << "(a initialized)" << endl;
}

A& A::operator=(const A&) {
  cout << "A::operator=" << endl;
  return *this;
}

A::~A() {
  cout << "A::~A()" << endl;
}

B::B():b(5) {
  cout << "B::B()" << endl;
}

B::B(int i, int j):b(j) {
  // WRONG !!!!
  // A's default constructor is called already
  // hence a is initialized
  // a(i) sets the value again! Compare to C::C(int,int)
  a = i;
  cout << "(a initialized)" << endl;
  cout << "B::B(int,int)" << endl;
}

B& B::operator=(const B& v) {
  a = v.a; 
  // can be done simpler!!
  // what if we do not have access to all of
  // the base's variables?
  // what if we have more than one there!
  // compare to C::operator=

  b = v.b;
  cout << "B::operator=" << endl;
  return *this; 
}

B::~B() {
  cout << "B::~B()" << endl;
}


C::C():c(5),y(2) {
  // ALRIGHTY! we actually bypassed Y::Y()!
  // the initializer is the only place where
  // we can explicitly override the default 
  // constructor of an instance variable
  cout << "C::C()" << endl;
}

C::C(int i,int j):A(i),c(j),y(3) {
  // RIGHT !!!!
  // A's a is initialized only once!
  cout << "C::C(int,int)" << endl;
}

C& C::operator=(const C& v) {
  A::operator=(v); 
  // YES
  // now we only have to initialize those 
  // vartiables that C declared, not the
  // ones of the super class

  c = v.c;
  cout << "C::operator=" << endl;
  return *this; 
}

C::~C() {
  cout << "C::~C()" << endl;
}

D::D() {
  cout << "D::D()" << endl;
}

D::D(int i,int j):C(i,j) {
  cout << "D::D(int,int)" << endl;
}

D& D::operator=(const D& v) {
   C::operator=(v);
   cout << "D::operator=" << endl;
   return *this;
}

D::~D() {
  cout << "D::~D()" << endl;
}
