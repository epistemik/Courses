// circle.h

#if !defined(_CIRCLE_H_)
#define _CIRCLE_H_

#include "shape.h"

class circle : public shape
{
   private:
      double radius;
 
   public:
      circle(double);
      double area() const;
      void print(ostream&) const;
};

class circle_instantiator : public shape_instantiator
{
   public:
      circle_instantiator();
      shape* instantiate(istream&,lexer&) const;
};

#endif
