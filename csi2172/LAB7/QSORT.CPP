#include <iostream.h>
#include <stdlib.h>

template<class T>
void quick_sort(T*,int,int,bool (*)(const T&, const T&));


template<class T>
void quick_sort(T* array, int l, int h, bool (*f)(const T&, const T&)) {
   int i = l-1, j = h+1;

   if (l >= h) return; 

   T cutoff = array[l];

   while(true) {
     do {
        --j;
     } while(f(cutoff,array[j]));

     do {
        ++i;
     } while(f(array[i],cutoff));

     if (i<j) {
        T tmp = array[i];
        array[i] = array[j];
        array[j] = tmp; 
     } else break;
  }


  quick_sort<T>(array,l,j,f);
  quick_sort<T>(array,j+1,h,f);
}

#include <string.h>

bool less_length(char* const& s1, char * const& s2) {
   return strlen(s1) < strlen(s2);
}

bool less_alphabetic(char * const& s1, char * const& s2) {
   return strcmp(s1,s2) < 0;
}

void print_args(int argc, char* argv[]) {
   for(int i=1; i< argc; i++) {
      cout << argv[i] << ' ';
   }
   cout << endl;
}

int main(int argc, char* argv[]) {

   
   quick_sort<char*>(argv,1,argc-1,less_alphabetic);
   cout << "alphabetic ordering: ";
   print_args(argc,argv);

   quick_sort<char*>(argv,1,argc-1,less_length);
   cout << "ordering by length: ";
   print_args(argc,argv);
  

   return 0;
}

