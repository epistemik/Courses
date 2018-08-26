#include "fraction.h"
#include <iostream.h>

fraction read() {

   cout << "Please eneter a fraction (numerator denominator): ";
   cout.flush();
 
   long n,d; 
   cin >> n >> d; 
  
   return fraction(n,d);
}

int main(void) {
 
 fraction f1 = read(),
          f2 = read();

 cout << "- " << f1 << " = " << -f1 << endl;
 cout << "- " << f2 << " = " << -f2 << endl;

 cout << f1 << " + " << f2 << " = " << (f1+f2) << endl; 
 cout << f1 << " - " << f2 << " = " << (f1-f2) << endl; 
 cout << f1 << " * " << f2 << " = " << (f1*f2) << endl; 
 cout << f1 << " / " << f2 << " = " << (f1/f2) << endl; 


 if (f1 <  f2) cout << f1 << " < " << f2 << endl;
 else          cout << "!(" << f1 << " < " << f2 << ")" << endl;
 
 if (f1 >  f2) cout << f1 << " > " << f2 << endl;
 else          cout << "!(" << f1 << " > " << f2 << ")" << endl;

 if (f1 <= f2) cout << f1 << " <= " << f2 << endl;
 else          cout << "!(" << f1 << " <= " << f2 << ")" << endl;

 if (f1 >= f2) cout << f1 << " >= " << f2 << endl;
 else          cout << "!(" << f1 << " >= " << f2 << ")" << endl;

 if (f1 == f2) cout << f1 << " == " << f2 << endl;
 else          cout << "!(" << f1 << " == " << f2 << ")" << endl;

 if (f1 != f2) cout << f1 << " != " << f2 << endl;
 else          cout << "!(" << f1 << " != " << f2 << ")" << endl;

 fraction f;


 f = f1;
 cout << f1 << " += " << f2 << " --> " << (f+=f2) << endl;

 f = f1;
 cout << f1 << " -= " << f2 << " --> " << (f-=f2) << endl;

 f = f1;
 cout << f1 << " *= " << f2 << " --> " << (f*=f2) << endl;

 f = f1;
 cout << f1 << " /= " << f2 << " --> " << (f/=f2) << endl;

 return 0;
}
