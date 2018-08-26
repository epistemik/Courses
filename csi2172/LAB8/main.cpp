#include "student.h"
#if defined(__WIN32__)
#include <strstream>
#else
#include <strstream.h>
#endif
#include <fstream.h>


int main(int argc, char* argv[]) {
  
    if (argc < 2) {
       cerr << argv[0] << " <student> [ <student> ... ]" << endl;
       cerr << "exmple:" << endl;
       cerr << "   " << argv[0] << " \"123 Santa\" \"456 Scrooge\"" << endl;
       return 1;
    }

    // OPEN A FILE STREAM FOR WRITING
    ofstream os("students.txt");

    if (!os) {
       cerr << "could not open students.txt for writing" << endl;
       return 1;
    }

    // FIRST WRITE ON THE FILE HOW MANY INSTANCES
    // WILL BE WRITTEN OUT
    os << (argc-1) << endl;

 
    for(int i=1; i< argc; i++) {
       student s;
       try {
          // CREATE A STRING STREAM FOR EACH ARGUMENT
          // AND SCAN IN A STUDENT
          istrstream is(argv[i],strlen(argv[i]));
          is >> s;
       } catch (read_error e) {
          os.close();
          cerr << "do not understand : " << argv[i] << endl;
          return 1;
       }
       // WRITE OUT THE STUDENT TO THE FILE
       os << s << endl;
    }

    // CLOSE THE FILE
    os.close();


    // OPEN THE AME FILE FOR READING 
    ifstream is("students.txt");

    // THE FIRST LINE IN THE FILE IS THE NUMBER OF INSTANCES
    // IN THE FILE
    int l;
    is >> l;

    for(int i=0; i<l; i++) {
       student s;
       try {
          // READ EACH INSTANCE
          is >> s;
       } catch (read_error e) {
          is.close();
          cerr << "could not read from file students.txt" << endl;
          return 1;
       }
       // AND WRITE IT ON THE SCREEN
       cout << s << endl;
    }

    // CLOSE INPUT FILE
    is.close();

    return 0;
}


     

