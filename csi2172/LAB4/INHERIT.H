// File:  inherit.h

#if !defined(_INHER_H_)
#define _INHER_H_

/*
 *
 *         +---+       +---+  +---+
 *         | A |       | X |  | Y |
 *         +---+       +---+  +---+
 *          /|\
 *           |
 *     +-----+-----+
 *     |           |
 *   +---+       +---+
 *   | B |       | C |
 *   +---+       +---+
 *                /|\
 *                 |
 *               +---+
 *               | D |
 *               +---+
 *
 *  Class "B" demonstrates the DO NOTs 
 *  Class "C" and "D" demonstrate the proper way
 *  Class "X" and "Y" demonstrate how instance variables
 *        get initialized
 *
 */

class X {
  public:
     X();
     X(int);
};

class Y {
  public:
     Y();
     Y(int);
};

class A {
  protected:
     int a;
  public:
     A();
     A(int);
     A& operator=(const A&);
     virtual ~A();
};

class B: public A {
  protected:
     int b;
     X x;
  public:
     B();
     B(int,int);
     B& operator=(const B&);
     ~B();
};

class C: public A {
  protected:
     int c;
     Y y;
  public:
     C();
     C(int,int);
     C& operator=(const C&);
     ~C();
};

class D: public C {
  public:
     D();
     D(int,int);
     D& operator=(const D&);
     ~D();
};

#endif
