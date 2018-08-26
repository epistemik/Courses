#include "person.h"
#include <iostream.h>
#include <string.h>

int lineno = 0;

person::person(): firstname(NULL), lastname(NULL), age(-1) {
   cout << ++lineno << " - DEFAULT CONSTRUCTOR" << endl;
}
           
person::person(char* lname,char* fname,int k) {
   copy(lname,fname,k);
   cout << ++lineno << " - SECOND CONSTRUCTOR" << endl;
}

person::person(const person& p) {
   copy(p.lastname,p.firstname,p.age);
   cout << ++lineno << " - COPY CONSTRUCTOR" << endl;
}

person::~person() {
   destroy();
   cout << ++lineno << " - DESTRUCTOR" << endl;
}

person& person::operator=(const person& p) {
   destroy();
   copy(p.lastname,p.firstname,p.age);
   cout << ++lineno << " - ASSIGNMENT OPERATOR" << endl;

   return *this;
}

void person::copy(char* lname,char* fname,int k) {
   age = k;

   if (lname!=NULL) {
      lastname = new char[strlen(lname)+1];
      strcpy(lastname,lname);
   } else lastname = NULL;

   if (fname!=NULL) {
      firstname = new char[strlen(fname)+1];
      strcpy(firstname,fname);
   } else firstname = NULL;

} 
 
void person::destroy() {
   delete [] firstname;
   delete [] lastname;
   
   firstname = lastname = NULL;
}

void person::print() {
   cout << ++lineno << ' ' << (firstname==NULL?"unknown":firstname) << ','
        << (lastname==NULL?"unknown":lastname);
   if (age!=-1) cout << " (age: " << age << ')';
   cout << endl;
} 

person foo(person p) {
   return p;
}
