// File ex2f1.cpp

#include "ex2.h"
#include <stdlib.h>

dice::dice(int s):sides(s),value(-1) {
}

void dice::roll() {
   #ifdef __WIN32__
   value = random(sides) + 1;
   #else
   value = (rand() % sides) + 1;  // % = MODULUS
   #endif
}

int dice::get_value() {
   return value;
}
