// File ex2f2.cpp

#include "ex2.h"
#include <iostream.h>

int main() {
  dice d;
  bool had_enough = false;

  do {
     d.roll();
     cout << "you rolled " << d.get_value() << endl;
     cout << "did you have enough? [y/n]" << endl;
     char c; // c is local to the loop!
     cin >> c;
     switch(c) {
       case 'y':
       case 'Y':
          cout << "I am sorry to hear that!" << endl;
          had_enough = true;
          break;
       case 'n':
       case 'N':
          break;
       default:
          cout << "Eh?" << endl;
          continue;
     }
  } while(!had_enough);

  return 0;
}
