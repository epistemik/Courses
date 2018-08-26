
#include "expression.h"
#include "parser.h"
#include <iostream.h>

int main() {

   parser P; // A parser

   context C; // A context

   bool done = false;
   while(!done) {
      try {
         expression *e = 0;
         const char* t = P.peek_token(cin);
         if (t == 0) {
            cerr << "unexpected end of file" << endl;
            return 1;
         }
         if (strcmp(t,"exit") == 0) {
            done = true;
         } else {
            e = P.read(cin); // READ EXPRESSION
            t = P.peek_token(cin);
            if (t == 0) {
               cerr << "unexpected end of file" << endl;
               return 1;
            }
            if (strcmp(t,";") != 0) {
               cerr << ';' << " expected instead of \""
                    << t << '\"' << endl;
               continue;
            }
         }
         P.consume_token(cin);
         if (e != 0) {
            // PRINT AND EVALUATE EXPRESSION
            cout << *e << " == " << e->evaluate(C) << endl;
         }
      } catch (parser::exception& ex) {
         // probably recoverable
         // start reading next expression to recover
         cerr << "parser::exception: " << ex << endl;
         continue;
      } catch (lexer::exception& ex) {
         // probably irrecoverable
         cerr << "lexer::exception: " << ex << endl;
         return 1;
      } catch (context::exception& ex) {
         // probably recoverable
         // start reading next expression to recover
         cerr << "context::exception: " << ex << endl;
      } catch (...) {
         cout << "irrecoverable error" << endl;
         return 1;
      }
   }

   return 0;
}
      
