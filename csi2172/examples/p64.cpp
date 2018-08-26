//FILE: p64.cpp
//NAME: Mark Sattolo

#include <iostream>
// using namespace std ;  // "undefined identifier 'std'" from Borland C++5

int* b ;

void f1(int* a)
  {
	cout << "f1: " << endl ;
	a = new int ;
	cout << " a == " << a << " and b == " << b << endl ;
	cout << " vp(a) == " << (void*)(a) << " and vp(b) == " << (void*)(b) << endl ;
	cout << " &a == " << &a << " and &b == " << &b << endl ;
	cout << " vp(&a) == " << (void*)(&a) << " and vp(&b) == " << (void*)(&b) << endl ;
  }

void f2(int*& a)
  {
	cout << "f2: " << endl ;
	a = new int ;
	cout << " a == " << a << " and b == " << b << endl ;
	cout << " vp(a) == " << (void*)(a) << " and vp(b) == " << (void*)(b) << endl ;
	cout << " &a == " << &a << " and &b == " << &b << endl ;
	cout << " vp(&a) == " << (void*)(&a) << " and vp(&b) == " << (void*)(&b) << endl ;
  }

void main()
  {
	cout << "STARTING MAIN() " << endl ;
	cout << " b == " << b << " and &b == " << &b << endl ;
	cout << " vp(b) == " << (void*)(b) << " and vp(&b) == " << (void*)(&b) << endl ;
	cout << endl << " Calling f1(b)... " << endl ;
	f1(b) ;
	cout << endl << " Calling f2(b)... " << endl ;
	f2(b) ;
	cout << endl << "Return to main() " << endl ;
	cout << " b == " << b << " and &b == " << &b << endl ;
	cout << " vp(b) == " << (void*)(b) << " and vp(&b) == " << (void*)(&b) << endl ;
  }
// main()
