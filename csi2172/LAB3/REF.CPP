#include <iostream.h>

int *b;

void f1(int *a) {
   cout << "f1" << endl;
   a = new int;
   cout << " a = " << (void*)(a)  << "  b = "  
        << (void*)(b) << endl;
   cout << "&a = " << (void*)(&a) << " &b = " 
        << (void*)(&b) << endl;
}

void f2(int *& a) {
   cout << "f2" << endl;
   a = new int;
   cout << " a = " << (void*)(a)  << "  b = "  
        << (void*)(b) << endl;
   cout << "&a = " << (void*)(&a) << " &b = " 
        << (void*)(&b) << endl;
}

int main() {
    cout << "b = " << (void*)b 
         << " &b = " << (void*)(&b) << endl;
    f1(b);
    f2(b);
    return 0;
}
   
