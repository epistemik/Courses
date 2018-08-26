// FILE: lexer.cpp
// written for the course 2172, 1999

#include "lexer.h"
#if defined(__GNUG__) 
  #include <strstream.h>
#else
  #include <sstream>
#endif

#include <stdlib.h>

// constructor
lexer::exception::exception(int l,const char* s): line_number(l) {
   strcpy(error,s);
}

// get line number
int lexer::exception::get_line_number() const {
   return line_number;
}

// get error
const char* lexer::exception::get_error() const {
   return error;
}

ostream& operator<<(ostream& os, const lexer::exception& le) {
   os << "near line " << le.get_line_number() << " :\'" 
      << le.get_error() << '\'';
   return os;
}

// constructor
lexer::lexer(int s):token(new char[s+1]),type(LEX_EOF),l(s),
   lineno(1),in_buffer(false) {
}

// put s back, so the next token returned by
// next_token is s
void lexer::putback() {
   in_buffer = true;
}

// destructor
lexer::~lexer() {
   delete [] token;
}

// return next token
// see header file "lexer.h"
const char* lexer::next_token(istream& is) {

  if (in_buffer) { // if a token was put back, return that
     in_buffer = false;
     return token;
  }

  int c; // char last read
  token[0] = '\0';

  int i = 0;

  // THE UGLY PIECE OF CODE BELOW IS A HANDCODED 
  // STATE MACHINE
  while((c = is.get()) != EOF) {
     if (i>=l) throw exception(lineno,"token too long");
     switch(c) {
        case '#': // comment, discard!
           while ((c = is.get()) != EOF) {
              if (c == '\n') {
                 lineno++;
                 break;
              }
           }
           continue;
        // "white spaces"
        case '\n':  // new line
        case ' ':   // space
        case '\t':  // tab
        case '\r':  // carriage return
           if (i==0) {
              if (c=='\n') lineno++;
              continue; 
           } else { // it is a token separator
              token[i] = '\0';
              is.putback((char)c);
              return token;
           }
        // quotes
        case '\'':
        case '\"':
        case '`': {
           if (i!=0) {
              token[i] = '\0';
              is.putback((char)c);
              return token;
           }
           char quote = (char)c;
           while((c = is.get())!=EOF) {
              if (i>=l) throw exception(lineno,"token too long");
              if (c == quote) {
                 token[i] = '\0';
                 type = LEX_STRING;
                 return token;
              } else if (c == '\n') {
                 lineno++;
                 throw exception(lineno,"string cannot span multiple lines");
              }
              if (c == '\\') {
                  // escape sequences: \n \t \b \\ \0 \r 
                  c = is.get();
                  switch(c) {
                     case 'n':
                        c = '\n';
                        break;
                     case 't':
                        c = '\t';
                        break;
                     case 'b':
                        c = '\b';
                        break;
                     case '\\':
                     case '\"':
                     case '\'':
                        // themselves
                        break;
                     case '0':
                        c = '\0';
                        break;
                     case 'r':
                        c = '\r';
                        break;
                     default:
                        throw exception(lineno,
                           "unkown quoted character in string");
                  }
              } 
              token[i++] = (char)c;
           }
           throw exception(lineno,"unterminated quoted string"); 
        }
        // special tokens
        case '+':
        case '-':
        case '/':
        case '%':
        case '$':
        case '*':
        case '(':
        case ')':
        case ',':
        case '^':
        case '~':
        case ';':
        case ':':
        case '.':
        case '\\':
        case '@':
        case '?':
        case '[':
        case ']':
        case '{':
        case '}':
           if (i == 0) {
              token[0] = (char)c;
              token[1] = '\0';
              type = LEX_SPECIAL;
           } else { 
              is.putback((char)c);
              token[i] = '\0';
           }
           return token;
        // if & or | occur in pairs, return the
        // pair  as one token
        case '&':
        case '|':
           char c2;
           if (i == 0) {
              token[0] = (char)c;
              type = LEX_SPECIAL;
              if ((c2 = (char)is.get()) == c) {
                 token[1] = (char)c;
                 token[2] = '\0';
              } else {
                 is.putback((char)c2);
                 token[1] = '\0';
              }
           } else {
              is.putback((char)c);
              token[i] = '\0';
           } 
           return token;
        // if these are followed by =, 
        // return the two characters as one token
        case '!':
        case '=':
        case '<':
        case '>':
           if (i == 0) {
              token[0] = (char)c;
              type = LEX_SPECIAL;
              if ((c = is.get()) == '=') {
                 token[1] = (char)c;
                 token[2] = '\0';
              } else {
                 is.putback((char)c);
                 token[1] = '\0';
              }
           } else {
              is.putback((char)c);
              token[i] = '\0';
           } 
           return token;
        // not special
        default:
           // numeric value
           if (c >= '0' && c <= '9') {
              if (i == 0) {
                 type = LEX_NUMERIC;
                 bool dot_found = false;
                 token[i++] = (char)c;
                 while((c = is.get()) != EOF) {
                    if (i>=l) throw exception(lineno,"token too long");
                    if (c >= '0' && c <= '9') {
                       token[i++] = (char)c;
                    } else if (c == '.') {
                       if (!dot_found) {
                          token[i++] = (char)c;
                          dot_found = true;
                       } else { // second dot
                          token[i] = '\0';
                          is.putback((char)c);
                          return token;
                       }
                    } else {
                      token[i] = '\0';
                      is.putback((char)c);
                      return token;
                    }
                 } // read numeral
                 is.putback((char)c);
                 token[i] = '\0';
                 return token;
              } else { // i != 0
                 token[i++] = (char)c;
              }
           } else if ( (c >= 'a' && c <= 'z') ||
                       (c >= 'A' && c <= 'Z') ||
                       c == '_' ) { // not a digit, but valid
              type = LEX_IDENTIFIER;
              token[i++] = (char)c;
           } else {
              throw exception(lineno,"invalid character");
           }
     } // switch 
  }

  if (i!=0) {
     token[i] = '\0'; // null term string
     return token;
  }

  // i == 0, END OF FILE MUST HAVE OCCURED
  type = LEX_EOF;
  return (char*)0; // EOF
}

// peek at token, but do not remove it from the stream
const char* lexer::peek_token(istream& is) const {
    const char* t = const_cast<lexer*>(this)->next_token(is);
    const_cast<lexer*>(this)->putback();

    return t;
}

// check_token(token)
// read the token, but rather than returning it,
// throw an exception if it is not the same
// as token
void lexer::check_token(istream& is,const char* token) {
   const char* string = get_token(is);

   if (strcmp(token,string) != 0) {
      exception err(lineno);
      ostringstream se(const_cast<char*>(err.get_error()),256);
      se << '\'' << token << '\'' 
         << " expected instead of " 
         << '\'' << string << '\'' << '\0';
      throw err;
   } 
}

// same as next_token, but throw an exception
// if the token read is not of the expected type
const char* lexer::check_token(istream& is,token_type t) {

   const char*  token = get_token(is);
   if (type != t) {
       throw exception(lineno,"type mismatch");
   }

   return token;
}

// reads a possibly signed numeric value and throws
// an exception if it is not
// CAREFUL, THERE SHOULD BE NO WHITE SPACE BETWEEN
// THE - (DASH) AND THE NUMBER
double lexer::read_numeric(istream& is) {
   
   const char*  token = get_token(is);

   double value = 0;
   if (type == LEX_NUMERIC) value = atof(token);
   else if (strcmp(token,"+")==0 || strcmp(token,"-") == 0) {
       double sign = token[0] == '-' ? -1 : 1;
       token = check_token(is,LEX_NUMERIC);
       value = sign*atof(token);
   } else {
      throw exception(lineno,"numeric expected");
   }

   return value; // never happens
}


// same as next_token, but throw an exception
// if the token read is the "END OF FILE"
const char* lexer::get_token(istream& is) {

   const char*  token = next_token(is);

   if (type == LEX_EOF) {
      throw exception(lineno,"unexpected end of file");
   }
   
   return token;
}


// type of last read token
token_type lexer::get_type() const {
   return type;
}

// current line number
int lexer::get_line_number() const {
   return lineno;
}

// set line number to v
void lexer::set_line_number(int v) {
   lineno = v;
}

// true if token is numeric (real or integer) 
bool lexer::is_numeric(const char* token) const {

  bool decpoint_found = false;
  
  int k = strlen(token);

  if (k == 0) return false;

  if (token[0] < '0' || token[0] > '9') return false;

  for(int i=1; i < k; i++) {
     if (token[i] == '.') {
        if (decpoint_found) return false;
        decpoint_found = true;
     } else if (token[i] < '0' || token[i] > '9') {
        return false;
     }
  }

  return true;
}
