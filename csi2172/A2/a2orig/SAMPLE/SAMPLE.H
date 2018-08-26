// File: sample.h

#if !defined(_SAMPLE_H_)
#define _SAMPLE_H_

#include "expression.h"

// e1 div e2 returns the result of the integer division (int)e1 / (int)e2
// if e1 and e2 are not integers, they are truncated
class div: public expression 
{  private:
      expression * lhs; // left hand side of div
      expression * rhs; // right hand side of div
   public:
      // NO DEFAULT CONSTRUCTOR!
      // div only makes sense with a left and right hand side
      div(expression*, expression*); // constructor
      div(const div&);		 // COPY CONSTRUCTOR
      ~div(); 				// DESTRUCTOR
      div& operator=(const div&); // ASSIGNMENT OPERATOR
 
      // OVERLOADED METHODS      
      double evaluate(context& C) const;
      expression* clone() const;
      void print(ostream& os) const;
};
expression* instantiate_div(expression*, expression*);

/*****************************************************************/

// e1 mod e2 returns the result of  (int)e1 % (int)e2 (modulus)
// if e1 and e2 are not integers, they are truncated
class mod: public expression 
{  private:
      expression * lhs; // left hand side of mod
      expression * rhs; // right hand side of mod
   public:
      // NO DEFAULT CONSTRUCTOR!
      // mod only makes sense with a left and right hand side
      mod(expression*, expression*); // constructor
      mod(const mod&); 	// COPY CONSTRUCTOR
      ~mod(); 				// DESTRUCTOR
      mod& operator=(const mod&); // ASSIGNMENT OPERATOR
 
      // OVERLOADED METHODS      
      double evaluate(context& C) const;
      expression* clone() const;
      void print(ostream& os) const;
};
expression* instantiate_mod(expression*, expression*);

/*****************************************************************/

// class truncate implements a unary expression which truncates its operand to an integer
class truncate : public expression 
{  private:
      expression* operand; // the operand of truncate
   public:
      // NO DEFAULT CONSTRUCTOR!
      // there has to be an operand
      truncate(expression*);
      truncate(const truncate&); 	// COPY CONSTRUCTOR
      ~truncate(); 				// DESTRUCTOR
      truncate& operator=(const truncate&); // ASSIGNMENT OPERATOR

      // OVERLOADED METHODS
      double evaluate(context& C) const;
      expression* clone() const;
      void print(ostream& os) const;
};
expression* instantiate_truncate(expression*);

/*****************************************************************/

// class hyp implements the hypotenuse function: hyp(a,b) = sqrt(a*a + b*b)
class hyp: public expression 
{  private:
      expression* arg1;  // first argument
      expression* arg2;  // second argument
   public:
      // NO DEFAULT CONSTRUCTOR !
      // hyp has to have two parameters
      hyp(expression*, expression*);
      hyp(const hyp&); 	// COPY CONSTRUCTOR
      ~hyp(); 			// DESTRUCTOR
      hyp& operator=(const hyp&);
  
      // OVERLOADED METHODS
      double evaluate(context& C) const;
      expression* clone() const;
      void print(ostream& os) const;
};
expression* instantiate_hyp(expression**, int); 

#endif