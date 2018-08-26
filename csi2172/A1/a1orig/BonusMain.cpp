// FILE:  bonusmain.cpp
// NAME:  Mark Sattolo
// STUDENT #:  428500
// SECTION:  CSI 2172A
// MARKING SECTION:  A4

#include "bonus.h"

int main() {

    int** m = allocate(5);
    m[2][1] = -1; // this also sets m[6][1]
    m[1][2] = -7; // this also sets m[7][2]
    print(cout,m,5);
    deallocate(m,5);

    cout << endl;

    m = allocate(4);
    print(cout,m,4);
    deallocate(m,4);

    cout << endl;

    m = allocate(1);
    print(cout,m,1);
    deallocate(m,1);
    
    return 0;
}
