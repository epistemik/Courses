#include "shapes.h"
#include <string.h>

shape::shape(const char* n):name(new char[strlen(n)+1]) {
   strcpy(name,n);
}

shape& shape::operator=(const shape& s) {
   delete [] name;
   name = new char[strlen(s.name)+1];
   strcpy(name,s.name);

   return *this;
}


shape::shape(const shape& s):name(new char[strlen(s.get_name())+1]) {
   strcpy(name,s.name);
}

shape::~shape() {
   delete [] name;
}

const char* shape::get_name() const {
   return name;
}

rectangle::rectangle(double i, double j):shape("rectangle"),a(i),b(j) {
}

rectangle& rectangle::operator=(const rectangle& r) {
   shape::operator=(r);
   a = r.a;
   b = r.b;

   return *this;
}

rectangle::rectangle(const rectangle& r):shape(r) {
   a = r.a;
   b = r.b;
}

rectangle::~rectangle() {
}

double rectangle::area() const {
   return a*b;
}



circle::circle(double i):shape("circle"),r(i) {
}

circle& circle::operator=(const circle& c) {
   shape::operator=(c);
   r = c.r;

   return *this;
}

circle::circle(const circle& c):shape(c) {
   r = c.r;
}

circle::~circle() {
}
   
double circle::area() const {

   return 3.14159*r*r;
}

