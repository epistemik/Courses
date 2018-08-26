// circle.cpp
// NAME:  Mark Sattolo
// STUDENT #:  428500// SECTION:  CSI 2172A// MARKING SECTION:  A4
#include "circle.h"

circle::circle(double r):radius(r)
	{	}

double circle::area() const 
	{  return 3.14159*radius*radius ;  }

void circle::print(ostream& os) const
	{  os << "circle" << ' ' << radius ;  }


circle_instantiator::circle_instantiator():shape_instantiator("circle")
	{	}

shape* circle_instantiator::instantiate(istream& is, lexer& L) const
	{
	L.check_token(is, get_name()) ;
	double v = L.read_numeric(is) ;
	return new circle(v) ; 
	}
