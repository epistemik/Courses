#include <iostream.h>

int fact1(int n) {
   return n == 0 ? 1 : n*fact1(n-1);
}

int main() {

   cout << "Enter a non negative integer in [0,10]>";
   cout.flush();
   int n;
   cin >> n;

   if (!cin) {
      cerr << "invalid input!" << endl;
      return 1;
   }

   int fact2 = 1;
   for(int i=2; i<=n; i++) {
       fact2 *= i;
   }

   int fact3 = 1;
   int i = 2;
   while(i<=n) {
     fact3 *= i;
     i++;
   }

   int fact4 = 1;
   i = 1;
   do {
      fact4 *= i;
      i++; 
   } while(i<=n);

   cout << n << "! = " << fact1(n) << endl
        << n << "! = " << fact2 << endl
        << n << "! = " << fact3 << endl
        << n << "! = " << fact4 << endl;

   return 0;
}
