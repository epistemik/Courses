// File: sample.cpp

#include "sample.h"
#include <math.h>

// CONSTRUCTOR
div::div(expression* l, expression* r): lhs(l), rhs(r) { }

// COPY CONSTRUCTOR: it creates a carbon copy, using clone
div::div(const div& d): lhs(d.lhs->clone()), rhs(d.rhs->clone()) { }

// DESTRUCTOR
div::~div()
	{
	delete lhs; delete rhs ;
	}

// ASSIGNMENT OPERATOR
div& div::operator=(const div& d)
	{
	delete lhs;	// destroy
	delete rhs;
	lhs = d.lhs->clone();	// copy
	rhs = d.rhs->clone();
	return *this;
	}

// evaluate: integer division of left and right hand sides
double div::evaluate(context& C) const 
	{
	// cast lhs and rhs into ints and do division
	return static_cast<int>(lhs->evaluate(C)) / static_cast<int>(rhs->evaluate(C)) ;
	}

// clone: create a carbon copy
expression* div::clone() const 
	{ return new div(*this) ; }

// print expression on os
void div::print(ostream& os) const 
	{
	lhs->print(os); // print lhs
	os << " div ";
	rhs->print(os); // print rhs
	}

// instantiator
expression* instantiate_div(expression* lhs, expression* rhs) 
	{ return new div(lhs,rhs) ; }

/*****************************************************************/

// CONSTRUCTOR
mod::mod(expression* l, expression* r): lhs(l), rhs(r) { }

// COPY CONSTRUCTOR: it creates a carbon copy, using clone
mod::mod(const mod& d): lhs(d.lhs->clone()), rhs(d.rhs->clone()) { }

// DESTRUCTOR
mod::~mod() 
	{
	delete lhs; delete rhs ;
	}

// ASSIGNMENT OPERATOR
mod& mod::operator=(const mod& d) 
	{
	delete lhs ; 	// destroy
	delete rhs;
	lhs = d.lhs->clone() ;	// copy
	rhs = d.rhs->clone();
	return *this;
	}

// evaluate: left hand side modulus right hand side
double mod::evaluate(context& C) const 
	{
	// cast lhs and rhs into ints and use %
	return static_cast<int>(lhs->evaluate(C)) % static_cast<int>(rhs->evaluate(C)) ;
	}

// clone: create a carbon copy
expression* mod::clone() const 
	{ return new mod(*this) ; }

// print expression on os
void mod::print(ostream& os) const 
	{
	lhs->print(os); // print lhs
	os << " mod ";
	rhs->print(os); // print rhs
	}

/*****************************************************************/

// instantiator
expression* instantiate_mod(expression* lhs, expression* rhs) 
	{ return new mod(lhs,rhs) ; }

// CONSTRUCTOR
truncate::truncate(expression* e):operand(e) { }

// COPY CONSTRUCTOR: it creates a carbon copy, using clone
truncate::truncate(const truncate& t): operand(t.operand->clone()) { }

// DESTRUCTOR
truncate::~truncate() 
	{ delete operand ; }

// ASSIGNMENT OPERATOR
truncate& truncate::operator=(const truncate& t) 
	{
	delete operand ; 	// destroy
	operand = t.operand->clone() ; 	// copy
	return *this;
	}

// evaluate: cast operand into an int
double truncate::evaluate(context& C) const 
	{
	return static_cast<int>(operand->evaluate(C)) ; 	// cast operand into int 
	}

// clone: create a carbon copy
expression* truncate::clone() const 
	{ return new truncate(*this) ; }

// print expression on os
void truncate::print(ostream& os) const 
	{
	os << '@'; 	// the truncate operator will be the @ sign
	operand->print(os); // print rhs
	}

// instantiator
expression* instantiate_truncate(expression* e) 
	{ return new truncate(e) ; }

/*****************************************************************/

// CONSTRUCTOR
hyp::hyp(expression* a1, expression* a2):arg1(a1),arg2(a2) { }

// COPY CONSTRUCTOR: it creates a carbon copy, using clone
hyp::hyp(const hyp& h):arg1(h.arg1->clone()),arg2(h.arg2->clone()) { }

// DESTRUCTOR
hyp::~hyp() 
	{
	delete arg1; delete arg2 ;
	}

// ASSIGNMENT OPERATOR
hyp& hyp::operator=(const hyp& h) 
	{
	delete arg1;	// destroy
	delete arg2;
	arg1 = h.arg1->clone();	// copy
	arg2 = h.arg2->clone();
	return *this;
	}

// evaluate: sqrt(arg1*arg1 + arg2*arg2)
double hyp::evaluate(context& C) const 
	{
	double a = arg1->evaluate(C);
	double b = arg2->evaluate(C);
	return sqrt(a*a + b*b);
	}

// clone: create a carbon copy
expression* hyp::clone() const 
	{ return new hyp(*this) ; }

// print expression on os
void hyp::print(ostream& os) const 
	{
	os << "hyp("; 	// the hyp operator will be "hyp"
	arg1->print(os); // print arg1
	os << ',';
	arg2->print(os); // print arg2
	os << ')';
	}

// instantiator
expression* instantiate_hyp(expression** argv, int) 
	{
	// we know that the second argument is 2 because hyp will be registered with two arguments
	return new hyp(argv[0],argv[1]);
	}
