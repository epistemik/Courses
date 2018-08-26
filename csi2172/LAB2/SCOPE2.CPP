#include <iostream.h>

int a = 6;  // a is declared and defined
         

void print(int i) {
  static int invocation = 1; // this variable retains its value
  int non_static = 0; // this does not
  cout << "i= " << i << ", invocation= " << invocation++ 
       << ", non_static= " << ++non_static << endl;
}
  

