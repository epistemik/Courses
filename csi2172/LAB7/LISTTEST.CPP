#include <iostream.h>
#include "list.h"

void print(list<double> L) {
  // passing by value, testing copy constructor
  for(list_iterator<double> I = L.first(); I.has_more_elements(); I++) {
     cout << *I << ' ';
  }
  cout << endl;
}

int main() {

  list<double> L1, L2;

  list_iterator<double> I;

  for(double i=0; i< 50; i+=0.5) {
      L1.insert_after(L1.last(),i);
      L2.insert_before(L2.first(),i);
  }

  list<double> L3;

  L3 = L1;

  I = L3.first();
 
  for(int i=0; i< 10; i++) {
     L3.remove(I);
     I = L3.first() + (3*i);
  }

  cout << "L1:" << endl;
  print(L1);

  cout << "L2:" << endl;
  print(L2);

  cout << "L3:" << endl;
  print(L3);

  return 0;
  
}
