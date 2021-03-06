// File: unary.h// NAME: Mark Sattolo// STUDENT #: 428500// SECTION: CSI 2172A// MARKING SECTION: A4
#if !defined(_UNARY_H_)
#define _UNARY_H_

#include "expression.h"

// class unary_plus implements a unary expression which returns its operand
class unary_plus : public expression 
{
	private:
		expression* operand; // the operand of unary_plus
	public:
		unary_plus(expression*);	// NO DEFAULT CONSTRUCTOR: there has to be an operand
		unary_plus(const unary_plus&); 	// COPY CONSTRUCTOR
		~unary_plus(); 				// DESTRUCTOR
		unary_plus& operator=(const unary_plus&); // ASSIGNMENT OPERATOR
		
		// OVERLOADED METHODS
		double evaluate(context& C) const;
		expression* clone() const;
		void print(ostream& os) const;
};
expression* instantiate_unary_plus(expression*) ;


// class unary_minus implements a unary expression which returns the negative of the operand
class unary_minus : public expression 
{
	private:
		expression* operand; // the operand of unary_minus
	public:
		unary_minus(expression*) ;	// NO DEFAULT CONSTRUCTOR: there has to be an operand
		unary_minus(const unary_minus&); 	// COPY CONSTRUCTOR
		~unary_minus(); 				// DESTRUCTOR
		unary_minus& operator=(const unary_minus&); // ASSIGNMENT OPERATOR
		
		// OVERLOADED METHODS
		double evaluate(context& C) const;
		expression* clone() const;
		void print(ostream& os) const;
};

expression* instantiate_unary_minus(expression*) ;


#endif
