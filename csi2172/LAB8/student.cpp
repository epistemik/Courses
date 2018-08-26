#include "student.h"

student::student():student_number(-1),name(NULL) {
}

student::student(int i, char* name):student_number(i) {
   copy(name);
}

student::student(const student& s):student_number(s.student_number) {
   copy(s.name);
}

student::~student() {
   delete [] name;
}

void student::copy(char* n) {
   name = new char[strlen(n) + 1];
   strcpy(name,n);
}


// A STUDENT ON THE STREAM IS REPRESENTED BY
// <student-number> <name>
// SO Santa WITH STUDENT NUMBER 123456 IS
// 123456 Santa
// ON THE STREAM

ostream& operator<<(ostream& os, const student& s) {
   os << s.student_number << ' ' << s.name;
   return os;
}


istream& operator>>(istream& is, student& s) {
   // destroy whatever is there
   delete [] s.name;

   char buffer[1024]; // for reading name
   int number;

   is >> number >> buffer;

   if (!is) {
      // something went wrong, throw an exception!
      throw read_error();
   }

   s.student_number = number;
   s.copy(buffer);

   return is;
}

