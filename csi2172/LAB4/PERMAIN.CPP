#include <iostream.h>
#include "person.h"

extern int lineno;

int main(void) {
   person people[2];
   people[0].print();
   people[1].print();
   cout << ++lineno << " array pepole declared" << endl;

   person john("DOE");
   cout << ++lineno << " john declared" << endl;

   person jane("JANE","SMITH",27);
   cout << ++lineno << " jane declared" << endl;

   people[0] = john;
   cout << ++lineno << " john assigned to p[0]" << endl;

   people[1] = foo(jane);
   cout << ++lineno << " jane assigned to p[1]" << endl;

   people[0].print();
   people[1].print();

   person *ptr;
   cout << ++lineno << " pointer to person is declared" << endl;

   ptr = new person;
   cout << ++lineno << " new person created dynamically" << endl;

   delete ptr;
   cout << ++lineno << " ptr destroyed" << endl;

   john = "KING";
   john.print();
   cout << ++lineno << " \"KING\" is assigned to john" << endl;

   cout << ++lineno << " end" << endl;

   return 0;
}


