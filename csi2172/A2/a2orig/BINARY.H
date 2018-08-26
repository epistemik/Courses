// File: binary.h// NAME: Mark Sattolo// STUDENT #: 428500// SECTION: CSI 2172A// MARKING SECTION: A4

#if !defined(_BINARY_H_)
#define _BINARY_H_

#include "expression.h"

// e1 + e2 returns the result of the addition of  e1 and e2
class addition: public expression 
{  
	private:
	      expression* lhs; // left hand side of addition
	      expression* rhs; // right hand side of addition
	public:
		// NO DEFAULT CONSTRUCTOR: addition only makes sense with a left and right hand side
		addition(expression*, expression*); // constructor
		addition(const addition&);		 // COPY CONSTRUCTOR
		~addition(); 				// DESTRUCTOR
		addition& operator=(const addition&); // ASSIGNMENT OPERATOR
		
		// OVERLOADED METHODS      
		double evaluate(context& C) const;
		expression* clone() const;
		void print(ostream& os) const;
};

expression* instantiate_addition(expression*, expression*);

/*****************************************************************/

// e1 - e2 returns the result of subtracting e2 from e1
class subtraction: public expression 
{
	private:
	      expression* lhs; // left hand side of subtraction
	      expression* rhs; // right hand side of subtraction
	public:
	      // NO DEFAULT CONSTRUCTOR: subtraction only makes sense with a left and right hand side
	      subtraction(expression*, expression*); // constructor
	      subtraction(const subtraction&); 	// COPY CONSTRUCTOR
	      ~subtraction(); 				// DESTRUCTOR
	      subtraction& operator=(const subtraction&); // ASSIGNMENT OPERATOR
	 
	      // OVERLOADED METHODS      
	      double evaluate(context& C) const;
	      expression* clone() const;
	      void print(ostream& os) const;
};
expression* instantiate_subtraction(expression*, expression*);

/*****************************************************************/

// e1 * e2 returns the result of multiplying e1 and e2
class multiplication: public expression 
{  
	private:
	      expression* lhs; // left hand side of multiplication
	      expression* rhs; // right hand side of multiplication
	public:
		// NO DEFAULT CONSTRUCTOR: multiplication only makes sense with a left and right hand side
		multiplication(expression*, expression*); // constructor
		multiplication(const multiplication&);		 // COPY CONSTRUCTOR
		~multiplication(); 				// DESTRUCTOR
		multiplication& operator=(const multiplication&); // ASSIGNMENT OPERATOR
		
		// OVERLOADED METHODS      
		double evaluate(context& C) const;
		expression* clone() const;
		void print(ostream& os) const;
};

expression* instantiate_multiplication(expression*, expression*);

/*****************************************************************/

// e1 / e2 returns the result of dividing e1 by e2
class division: public expression 
{
	private:
	      expression* lhs; // left hand side of division
	      expression* rhs; // right hand side of division
	public:
	      // NO DEFAULT CONSTRUCTOR: division only makes sense with a left and right hand side
	      division(expression*, expression*); // constructor
	      division(const division&); 	// COPY CONSTRUCTOR
	      ~division(); 				// DESTRUCTOR
	      division& operator=(const division&); // ASSIGNMENT OPERATOR
	 
	      // OVERLOADED METHODS      
	      double evaluate(context& C) const;
	      expression* clone() const;
	      void print(ostream& os) const;
};
expression* instantiate_division(expression*, expression*);

/*****************************************************************/

// e1^e2 returns the result of raising e1 to the power e2
class power: public expression 
{
	private:
	      expression* lhs; // left hand side of division
	      expression* rhs; // right hand side of division
	public:
	      // NO DEFAULT CONSTRUCTOR: power only makes sense with a left and right hand side
	      power(expression*, expression*); // constructor
	      power(const power&); 	// COPY CONSTRUCTOR
	      ~power(); 				// DESTRUCTOR
	      power& operator=(const power&); // ASSIGNMENT OPERATOR
	 
	      // OVERLOADED METHODS      
	      double evaluate(context& C) const;
	      expression* clone() const;
	      void print(ostream& os) const;
};
expression* instantiate_power(expression*, expression*);

#endif
