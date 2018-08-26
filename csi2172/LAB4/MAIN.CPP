#include "inher.h"
#include <iostream.h>

int main() {
    A a;
    cout << "a declared" << endl;
    B b1,b2(2,3);
    cout << "b1 and b2 declared" << endl;
    C c1,c2(2,3);
    cout << "c1 and c2 declared" << endl;

    cout << "local scope starts" << endl;
    {
     D d;
     cout << "d declared" << endl;
    }
    cout << "local scope ends" << endl;

    b1 = b2;
    cout << "b1 = b2" << endl;

    c1 = c2;
    cout << "c1 = c2" << endl;

}
