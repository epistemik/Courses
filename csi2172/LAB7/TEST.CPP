#include "ilist.h"
#include <iostream.h>
#include <stdlib.h>

int rrr(int x) {
   #ifdef __WIN32__
   return random(x);
   #else
   return (random() % x);
   #endif
}

int main() {
   ilist<int> L;
   const int K = 1000;

   try {
      cout << "inserting " << K << " elements" << endl;
      for(int i=0; i<K/2; i++) {
         L.insert_after(i-1,i);
      }
      for(int i=K/2; i<K; i++) {
         L.insert_before(L.length(),i);
      }


      cout << "printing " << L.length() << " elements from 0..." << endl;
      for(int i=0; i<L.length(); i++) {
        cout << L[i] << ' ';
        cout.flush();
      }
      cout << endl;

      cout << "printing " << L.length() << " elements from " << L.length()
           << " backwards:" << endl;
      for(int i=L.length()-1; i>=0; i--) {
        cout << L[i] << ' ';
        cout.flush();
      }
      cout << endl;

      int k = L.length()/2;

      cout << "deleting " << k << " elements from random positions" << endl;
      for(int i=0; i<k; i++) {
         L.remove(rrr(L.length()));
      } 

      ilist<int> L2(L); // TEST COPY CONSTRUCTOR

      k = k/2;
      cout << "inserting " << (2*k) 
           << " elements after and before random indices" << endl;

      for(int i=0; i<k; i++) {
        int x = rrr(L2.length());
        L2.insert_after(x,x);
        x = rrr(L2.length());
        L2.insert_before(x,x);
      }

      ilist<int> L3;

      L3 = L2; // TEST ASSIGNMENT OPERATOR

      cout << "printing " << L3.length() << " elements from random positions"
           << endl;
      for(int i=0; i<L3.length(); i++) {
        cout << L3[rrr(L3.length())] << ' ';
        cout.flush();
      }
      
      cout << "bye!" << endl;

   } catch (ilist_exception& e) {
     cerr << e.error << endl;
     return 1;
   }

   return 0;
}
