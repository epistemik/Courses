#if !defined(_STUDENT_H_)
#define _STUDENT_H_

#include <iostream.h>
#include <string.h>

struct read_error {
};


class student {
   private:
       int student_number;
       char* name;

       void copy(char*);

   public:
       student();
       student(int,char*);
       student(const student&);
       ~student();

   friend ostream& operator<<(ostream&, const student&);
   friend istream& operator>>(istream&, student&);
};

#endif

