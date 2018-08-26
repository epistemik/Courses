#include "shapes.h"
#include <iostream.h>

const int L=5;

int main() {

   shape** shapes = new shape*[L];

   int i=0;
   while (i < L) {

      cout << "SELECT: " << endl << endl 
           << "   1. Circle" << endl
           << "   2. Rectangle" << endl << endl
           << "> ";
      cout.flush();
      
      
      char c;

      c = (char)cin.get();

      switch(c) {
         case '1':
               cout << "Enter radius> ";
               cout.flush();

               double r;
               cin >> r;

               shapes[i] = new circle(r);
               i++;
               break;

         case '2':
               cout << "Enter length of one side> ";
               cout.flush();

               double a;
               cin >> a;

               cout << "Enter length of other side> ";
               cout.flush();

               double b;
               cin >> b;
 
               shapes[i] = new rectangle(a,b);
               i++;
               break;

         default:

               cout << (char)c << '?' << endl;
      }

      cin.get();
   }

   for(int i=0; i<L; i++) {

      cout << shapes[i]->get_name() << " with area " << shapes[i]->area() 
           << endl;

      delete shapes[i];

   }

   delete [] shapes;

   return 0;
}
 
   
