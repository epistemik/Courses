#include <iostream.h>
#if defined(__WIN32__)
#include <strstream>
#else
#include <strstream.h>
#endif
#include <string.h>

class A_exception {
};

class A {
   protected:
      // A_reader is a function which
      // takes an istream by reference
      // and returns a new A object
      typedef A* (* A_reader)(istream&);

      static char** magic_numbers;
      static A_reader* readers;
      static int n;

   public:
      static A* read(istream&);
      static void add_reader(const char*,A_reader);
      static void destroy_readers();
      virtual void print(ostream&) const = 0;
};

class B:  public A {
   protected:
      int i;

   public:
      B(int);
      virtual void print(ostream&) const;
};

class C: public A {
   protected:
      char * s;

   public:
      C(const char*);
      virtual ~C();
      virtual void print(ostream&) const;
};

void A::add_reader(const char* magic_number, A_reader reader) {

   for(int i=0; i<n; i++) {
      if (strcmp(magic_number,magic_numbers[i]) == 0) {
         throw A_exception();
         // magic_number already exists, programmers error
      }
   }

   A_reader* new_readers = new A_reader[n+1];
   char** new_magic_numbers = new char*[n+1];
   new_readers[n] = reader;
   new_magic_numbers[n] = new char[strlen(magic_number)+1];
   strcpy(new_magic_numbers[n],magic_number);

   for(int i=0; i<n; i++) {
      new_readers[i] = readers[i];
      new_magic_numbers[i] = magic_numbers[i];
   }

   delete [] readers;
   delete [] magic_numbers;

   readers = new_readers;
   magic_numbers = new_magic_numbers;

   n++;
}

void A::destroy_readers() {
   for(int i=0; i<n; i++) {
      delete magic_numbers[i];
   }

   delete [] magic_numbers;
   delete [] readers;
   magic_numbers = 0;
   readers = 0;
   n = 0;
}

A* A::read(istream& is) {
   char magic_number[128];
   is >> magic_number;

   for(int i=0; i<n; i++) {
      if (strcmp(magic_number,magic_numbers[i]) == 0) {
         return (readers[i])(is);
      }
   }

   throw A_exception();
   // No such magic_number
}

A::A_reader* A::readers = 0;
int A::n = 0;
char** A::magic_numbers = 0;



B::B(int a):i(a) {
}

void B::print(ostream& os) const {
   os << "B_MAGIC" << ' ' << i;
}

A* B_reader(istream& is) {
   int a;
   is >> a;
   return new B(a);
}


C::C(const char* c):s(new char[strlen(c)+1]) {
   strcpy(s,c);
}

C::~C() {
   delete [] s;
}

void C::print(ostream& os) const {
   os << "C_MAGIC" << ' ' << s;
}

A* C_reader(istream& is) {
   char buffer[256];
   is >> buffer;
   return new C(buffer);
}


class A_WRAPPER {
   protected:
      A* ptr;
   public:
      A_WRAPPER();
      A* get_A();

   friend istream& operator>>(istream&,A_WRAPPER&);
}; 

A_WRAPPER::A_WRAPPER():ptr(0) {
}

A* A_WRAPPER::get_A() {
   return ptr;
}


istream& operator>>(istream& is, A_WRAPPER& w) {
   w.ptr = A::read(is);

   return is;
}

ostream& operator<<(ostream& os, const A& a) {
   a.print(os);

   return os;
}
   


int main(int argc, char* argv[]) {

   A::add_reader("B_MAGIC",B_reader);
   A::add_reader("C_MAGIC",C_reader);
   
   for(int i=1; i<argc; i++) {
      try {
         istrstream is(argv[i],strlen(argv[i]));
         A_WRAPPER w;
         is >> w;
         cout << *(w.get_A()) << endl;
      } catch (...) {
         cout << "something is wrong with: " << argv[i] << endl;
      }
   }

   A::destroy_readers();

   return 0;
}


