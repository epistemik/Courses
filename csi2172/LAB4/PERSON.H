#if !defined(_PERSON_H_)
#define _PERSON_H_

class person  {
   private:
      char * firstname;
      char * lastname;
      int    age;

      void copy(char* = (char*)0,char* = (char*)0,int = -1);
                   // A PRIVATE FUNCTION, WHICH CAN TAKE
                   // 0,1,2 OR 3 ARGUMENTS. IF NOT GIVEN
                   // THE DEFAULT VALUES ARE USED
      void destroy();
                   // A PRIVATE FUNCTION, WHICH DEALLOCATES
                   // DYNAMICALLY ALLOCATED MEMORY
   public:
      person();    // DEFAULT CONSTRUCTOR
      person(char*, char* =(char*)0,int=-1);
                   // A CONSTRUCTOR WICH CAN TAKE 1,2 OR
                   // 3 ARGUMENTS, THE SECOND AND THIRD
                   // ARE AUTOMATICALLY SET TO THE DEFUALT
                   // IF NOT PROVIDED
      person(const person&); // THE COPY CONSTRUCTOR
      ~person();   // THE DESTRUCTOR
      person& operator=(const person&); // THE ASSIGNMENT OPERATOR
      void print();
};

person foo(person);

#endif
