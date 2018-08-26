#if !defined(_PARSER_H_)
#define _PARSER_H_

#include "lexer.h"
#include "expression.h"
#include <iostream.h>

#if !defined(LEX_BUF)
#define LEX_BUF 512
#endif

/* Expression parser class
 *
 * - reads unary, binary and function expressions
 * - brackets binary expressions according to precedence
 * - observs precedence overriden by parantheses
 * - reads variables (as identifiers)
 */
class parser {

   /* exceptional conditions detected during parsing
    *
    */
   public: class exception {
      private:
         char err[512];
      
      public:
         // constructor
         exception(const char*);
         // print error on stream
         void print(ostream&) const; 
   };

   // definitions of instantiators
   // used to create the expression 

   // unary operator instantiator, argument is the operand
   typedef expression* (*unary_instantiator)(expression*);

   // binary operator instantiator, arguments are left-hand-side 
   // and right-hand-side
   typedef expression* (*binary_instantiator)(expression*, expression*);
   
   // function instantiator, arguments are a  vector of arguments
   // to the function and the length of the vector
   typedef expression* (*function_instantiator)(expression**, int);

   // shallow destructor which does not destroy the left and right
   // hand sides of binary exressions, it is an optimization
   // if one does not provide one, it does it the 'inefficient way'
   typedef void (*shallow_destructor)(expression*);

   // sub expression represents an expression in parantheses
   class sub_expression: public expression {
       private:
          // the expression in parantheses
          expression* e;
       public:
         sub_expression(expression*);
         sub_expression(const sub_expression&);
         sub_expression& operator=(const sub_expression&);
         ~sub_expression();
         double evaluate(context&) const;
         void print(ostream&) const;
         expression* clone() const;
   };

   // _binary_expression is a wrapper for a binary expression
   // this class is used to fix the precedence order of
   // binary expressions
   class _binary_expression: public expression {
      private:
         // binary expression
         expression* e;
         expression* lhs; // alias e's left-hand-side
         expression* rhs; // alias e's right-hand-side
         int prec; // precedence

         // instantiator which creates e from lhs and rhs
         binary_instantiator inst;

         // shallow destructor is called instead of
         // delete and clone (which is somewhat inefficient)
         // if specified
         shallow_destructor destr;

         // if lhs has higher precedence than this 
         void fix_left();

         // if rhs has higher precedence than this 
         void fix_right();
 
      public:
         _binary_expression(expression*,expression*, int,
            binary_instantiator, shallow_destructor);
         _binary_expression(const _binary_expression&);
         _binary_expression& operator=(const _binary_expression&);
         double evaluate(context&) const;
         void print(ostream&) const;
         expression* clone() const;
         int get_precedence() const;
         ~_binary_expression();
   };

   private:

      // names of unary operators
      char** unary_operators;

      // names of binary operators
      char** binary_operators;

      // names of functions
      char** functions;

      // unary operator instantiators
      unary_instantiator* unary_instantiators;

      // binary operator instantiators
      binary_instantiator* binary_instantiators;
      // shallow destructors, if any
      shallow_destructor* destructors;

      // function instantiators
      function_instantiator* function_instantiators;

      // precedences of binary operators
      int* precs; 

      // arity of functions
      int* argcs;

      int nu; // number of unary operators
      int nb; // number of binary operators
      int nf; // number of functions

      // lexical analyzer used in parsing
      // L is mutable because the stream state
      // is not part of the logical description
      // of a parser
      mutable lexer L;

      // reads a non-binary expression
      expression* read_one(istream&) const;

      // memory clean-up
      void destroy();

      // carbon copy
      void copy(const parser&);

      // is it a unary operator
      bool is_unary(const char*) const;
    
      // is it a binary operator
      bool is_binary(const char*) const;

      // is it a function
      bool is_function(const char*) const;

      // is it punctuation
      bool is_punctuation(const char*) const;

      // is it a reserved name
      bool is_reserved(const char*) const;
 
      
   public:
      parser();
      parser(const parser&);
      parser& operator=(const parser&);
      ~parser();

      // reads an expression from the stream
      expression* read(istream&) const; 

      // take peek at the next token without removing it
      const char* peek_token(istream&) const;

      // remove the next token from the stream
      void consume_token(istream& is) const;

      // add_unary_instantiator(n,i)
      // add a unary instantiator i with name n
      void add_unary_instantiator(const char*, unary_instantiator);

      // add_unary_instantiator(n,p,i)
      // add a binary instantiator i with name n and precedence p
      void add_binary_instantiator(const char*, int, binary_instantiator,
         shallow_destructor = 0);

      // add_function_instantiator(n,argc,i)
      // add a function instantiator i with name n and argument count argc
      void add_function_instantiator(const char*, int, function_instantiator);
};

// print parser exceptions to the stream
ostream& operator<<(ostream&, parser::exception&); 


#endif
