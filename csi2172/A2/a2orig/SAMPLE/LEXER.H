// FILE: lexer.h
// written for the course 2172, 1999
//
#if !defined(_LEXER_H_)
#define _LEXER_H_

#include <string.h>
#include <iostream.h>



/* LEXER TYPES
 * 
 * LEX_NUMERIC (like): 0, 1, 3.455
 * LEX_IDENTIFIER (like): hello, _a, cow2, ___, _bimbo_
 * LEX_STRING (like): "hello world", 'hello world' and
 *                    `hello world`
 * LEX_SPECIAL (like): +, -, <=, !, @, ...
 * LEX_EOF: no token read yet, or end of file reached
 */
enum token_type {LEX_NUMERIC, LEX_IDENTIFIER, LEX_STRING, LEX_SPECIAL, LEX_EOF};


/* simple LEXical analyzER
 *
 * token types
 *       o unsigned real numbers in decimal notation
 *         (like 0.5, 434.232, 3.14, NOT .5)
 *
 *       o unsigned integers
 *         (like 2, 0, 122233)
 *
 *       o identifiers, first letter alphabetic or _
 *         subsequent letters are alphanumreic or _
 *         (like a, a1, _a, _, __a, hello)
 *
 *       o special tokens
 *          +,  -,  *,  /,  %
 *         &&, ||, !,
 *          &,  |, 
 *          (,  ),  [,  ],  {,  }
 *          =, ==, <=, >=,  <,  >,
 *          .,  @,  \,  ~,  ?,  $, ;, ,, : 
 *
 *       o every character following # (sharp or hash) until the
 *         end of the line is treated as a comment and discarded
 *
 *       o quoted character sequences may include spaces and
 *         punctuation characters, but they cannot span multiple 
 *         lines (line "hello world", 'how are you?' `life sucks`)
 *
 *       o (char*)0 is returned if the Enf Of File (EOF)
 *         condition occured
 *
 *       o other characters or combinations of charactres throw
 *         a lexer exception
 *
 *       o corrupt stream forces an exception thrown
 *
 *       o a token longer than the buffer forces an exception thrown
 */
class lexer {
   // This error object is thrown whenever a 
   // lexer error occurs
   //
   public: class exception {
      private:
         char error[256];   // description of error
         int line_number;   // line number error detected
      public:
         exception(int,const char* ="lexer error"); // constructor
         int get_line_number() const;
         const char* get_error() const;
   };

   private:
      char* token; // token buffer

      token_type type; // type of last read token

      int l;       // length of buffer

      int lineno;  // current line number

      mutable bool in_buffer;

      // a lexer should not be passed by value
      // nor it should be assigned
      lexer& operator=(const lexer&);
      lexer(const lexer&);

   public:
      // by default the token buffer is 256 characters long
      lexer(int = 256);
      ~lexer();

      // read the next token from the stream and return it
      // if a token was putback, then that token is returend 
      // instead, on EOF 0 is returned
      const char* next_token(istream&);

      // return the type of the last read token 
      token_type get_type() const;

      // check_token(token)
      // read the token, but rather than returning it,
      // throw an exception if it is not the same
      // as token
      void check_token(istream&,const char*);

      // peek_token()
      // look at the token, but do not remove it from the 
      // stream, it uses next_token, so 0 may be returned
      const char* peek_token(istream&) const;

      // same as next_token, but throw an exception
      // if the token read is not of the expected type
      const char* check_token(istream&,token_type);

      // reads a possibly signed numeric value and throws
      // an exception if it is not
      double read_numeric(istream&);

      // same as next_token, but throw an exception
      // if the token read is the "END OF FILE"
      const char* get_token(istream&);

      // put the token back so it is the next token returned
      // as opposed to one read from the stream
      void putback();

      // set or re-set the line number, useful if the stream
      // read by the lexer changes
      void set_line_number(int = 1);

      // return line number
      int get_line_number() const;

      // true if the argument is numeric (real or integer) 
      bool is_numeric(const char*) const; 
};

ostream& operator<<(ostream&, const lexer::exception&);

#endif
