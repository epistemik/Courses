// File: varcontext.h// NAME: Mark Sattolo// STUDENT #: 428500// SECTION: CSI 2172A// MARKING SECTION: A4
#if !defined(_VARCONTEXT_H_)
#define _VARCONTEXT_H_

#include "expression.h"

class varcontext : public context
	{
   private:
      char**	names ; // array of names
      double*  values ;  // array of values
      int  	 	size ;  // size of array

   public:
      varcontext();   // Constructor

      // existing methods
      void add_identifier(const char*, double) ;
      void set_value(const char*, double) ;
      double get_value(const char*) const ;

      int find_var(const char*) const ;  // check existing variables

      ~varcontext(); // Destructor
};

ostream& operator<<(ostream& os, const varcontext::exception&) ;

#endif
