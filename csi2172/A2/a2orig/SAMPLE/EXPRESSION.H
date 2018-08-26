// File: expression.h

#if !defined(_EXPRESSION_H_)
#define _EXPRESSION_H_

#include <iostream.h>

// CONTEXT
// an instance of a context contains variables, where a variable is a name with a value
class context {

   // identifier exception
   // it should be thrown if identifier is requested but does not occur in the context
   // or if it is attempted to be added twice
   public: class exception {
      private:
         char identifier[256];

      public:
         exception(const char*);
         const char* get_identifier() const;
   };


   public:
      // add_identifier(n,v)
      // add a new identifier to the context with name n and value v
      virtual void add_identifier(const char*, double = 0);

      // set_value(n,v)
      // set the value of n to v
      virtual void set_value(const char*, double);

      // get_value n
      // get the value of n
      virtual double get_value(const char*) const;

      virtual ~context();
};

// operator<< 
ostream& operator<<(ostream& os, const context::exception&);


// EXPRESSION
// abstract expression class
// every expression is derived from this
class expression {

   public:

      // evaluate expression
      virtual double evaluate(context&) const = 0;

      // print expression to stream
      virtual void print(ostream&) const = 0;

      // create a carbon copy of expression
      virtual expression* clone() const = 0;

      virtual ~expression();

};

// print expression to stream
ostream& operator<<(ostream& os, const expression&);

// constant
class constant: public expression {

   private:
      // value of constant
      double v;

   public:
      constant(double);

      // C.evaluate = C.v
      double evaluate(context&) const;

      // C.print(os) = os << C.v
      void print(ostream&) const;

      // C.clone() = new constant(C.v)
      expression* clone() const;
};

// variable is an identifier whose value is determined from a context
class variable: public expression {
   private:
      // name of variable
      char* name;

   public:
      variable(const char*);
      variable& operator=(const variable&);
      variable(const variable&);
      ~variable();

      // V.evaluate(C) = C.get_value(V.name)
      double evaluate(context&) const;

      // V.print(os) = os << V.name
      void print(ostream&) const;

      // V.clone() = new Variable(V)
      expression* clone() const;

      const char* get_name() const;
};


#endif
