// File: binary.cpp// NAME: Mark Sattolo// STUDENT #: 428500// SECTION: CSI 2172A// MARKING SECTION: A4

#include "binary.h"
#include <math.h>


/*********************************************************
	ADDITION
*********************************************************/

// CONSTRUCTOR
addition::addition(expression* l, expression* r): lhs(l), rhs(r)
	{ }

// COPY CONSTRUCTOR: it creates a carbon copy, using clone
addition::addition(const addition& d): lhs( d.lhs->clone() ), rhs( d.rhs->clone() )
	{ }

// DESTRUCTOR
addition::~addition()
	{
	delete lhs ;
	delete rhs ;
	}

// ASSIGNMENT OPERATOR
addition& addition::operator=(const addition& d)
	{
	delete lhs;	// destroy
	delete rhs;
	lhs = d.lhs->clone();	// copy
	rhs = d.rhs->clone();
	return *this;
	}

// evaluate: add left and right hand sides
double addition::evaluate(context& C) const
	{
	return ( lhs->evaluate(C) ) + ( rhs->evaluate(C) ) ;
	}

// clone: create a carbon copy
expression* addition::clone() const
	{ return new addition(*this) ; }

// print expression on os
void addition::print(ostream& os) const
	{
	lhs->print(os); // print lhs
	os << " + ";
	rhs->print(os); // print rhs
	}

// instantiator
expression* instantiate_addition(expression* lhs, expression* rhs)
	{ return new addition(lhs,rhs) ; }


/*********************************************************
	SUBTRACTION
*********************************************************/

// CONSTRUCTOR
subtraction::subtraction(expression* l, expression* r): lhs(l), rhs(r)
	{ }

// COPY CONSTRUCTOR: it creates a carbon copy, using clone
subtraction::subtraction(const subtraction& d): lhs( d.lhs->clone() ), rhs( d.rhs->clone() )
	{ }

// DESTRUCTOR
subtraction::~subtraction()
	{
	delete lhs ;
	delete rhs ;
	}

// ASSIGNMENT OPERATOR
subtraction& subtraction::operator=(const subtraction& d)
	{
	delete lhs ; 	// destroy
	delete rhs ;
	lhs = d.lhs->clone() ;	// copy
	rhs = d.rhs->clone() ;
	return *this ;
	}

// evaluate: left hand side minus right hand side
double subtraction::evaluate(context& C) const
	{  return ( lhs->evaluate(C) ) - ( rhs->evaluate(C) ) ;  }

// clone: create a carbon copy
expression* subtraction::clone() const
	{  return new subtraction(*this) ;  }

// print expression on os
void subtraction::print(ostream& os) const
	{
	lhs->print(os); // print lhs
	os << " - ";
	rhs->print(os); // print rhs
	}

// instantiator
expression* instantiate_subtraction(expression* lhs, expression* rhs)
	{  return new subtraction(lhs,rhs) ;  }


/*********************************************************
	MULTIPLICATION
*********************************************************/

// CONSTRUCTOR
multiplication::multiplication(expression* l, expression* r): lhs(l), rhs(r)
	{ }

// COPY CONSTRUCTOR: it creates a carbon copy, using clone
multiplication::multiplication(const multiplication& d): lhs( d.lhs->clone() ), rhs( d.rhs->clone() )
	{ }

// DESTRUCTOR
multiplication::~multiplication()
	{
	delete lhs ;
	delete rhs ;
	}

// ASSIGNMENT OPERATOR
multiplication& multiplication::operator=(const multiplication& d)
	{
	delete lhs ;	// destroy
	delete rhs ;
	lhs = d.lhs->clone() ;	// copy
	rhs = d.rhs->clone() ;
	return *this ;
	}

// evaluate: multiplication of left and right hand sides
double multiplication::evaluate(context& C) const
	{  return ( lhs->evaluate(C) ) * ( rhs->evaluate(C) ) ;  }

// clone: create a carbon copy
expression* multiplication::clone() const
	{ return new multiplication(*this) ; }

// print expression on os
void multiplication::print(ostream& os) const
	{
	lhs->print(os); // print lhs
	os << " * ";
	rhs->print(os); // print rhs
	}

// instantiator
expression* instantiate_multiplication(expression* lhs, expression* rhs)
	{ return new multiplication(lhs,rhs) ; }


/*********************************************************
	DIVISION
*********************************************************/

// CONSTRUCTOR
division::division(expression* l, expression* r): lhs(l), rhs(r)
	{ }

// COPY CONSTRUCTOR: it creates a carbon copy, using clone
division::division(const division& d): lhs( d.lhs->clone() ), rhs( d.rhs->clone() )
	{ }

// DESTRUCTOR
division::~division()
	{
	delete lhs ;
	delete rhs ;
	}

// ASSIGNMENT OPERATOR
division& division::operator=(const division& d)
	{
	delete lhs ; 	// destroy
	delete rhs ;
	lhs = d.lhs->clone() ;	// copy
	rhs = d.rhs->clone() ;
	return *this ;
	}

// evaluate: left hand side divided by right hand side
double division::evaluate(context& C) const
	{  return ( lhs->evaluate(C) ) / ( rhs->evaluate(C) ) ;  }

// clone: create a carbon copy
expression* division::clone() const
	{  return new division(*this) ;  }

// print expression on os
void division::print(ostream& os) const
	{
	lhs->print(os); // print lhs
	os << " / ";
	rhs->print(os); // print rhs
	}

// instantiator
expression* instantiate_division(expression* lhs, expression* rhs)
	{  return new division(lhs,rhs) ;  }


/*********************************************************
	POWER
*********************************************************/

// CONSTRUCTOR
power::power(expression* l, expression* r): lhs(l), rhs(r)
	{ }

// COPY CONSTRUCTOR: it creates a carbon copy, using clone
power::power(const power& d): lhs( d.lhs->clone() ), rhs( d.rhs->clone() )
	{ }

// DESTRUCTOR
power::~power()
	{
	delete lhs ;
	delete rhs ;
	}

// ASSIGNMENT OPERATOR
power& power::operator=(const power& d)
	{
	delete lhs ; 	// destroy
	delete rhs ;
	lhs = d.lhs->clone() ;	// copy
	rhs = d.rhs->clone() ;
	return *this ;
	}

// evaluate: left-hand side raised to the power of the right-hand side
double power::evaluate(context& C) const
	{  return pow( ( lhs->evaluate(C) ) , ( rhs->evaluate(C) ) )  ;  }

// clone: create a carbon copy
expression* power::clone() const
	{  return new power(*this) ;  }

// print expression on os
void power::print(ostream& os) const
	{
	lhs->print(os); // print lhs
	os << " ^ ";
	rhs->print(os); // print rhs
	}

// instantiator
expression* instantiate_power(expression* lhs, expression* rhs)
	{  return new power(lhs,rhs) ;  }

