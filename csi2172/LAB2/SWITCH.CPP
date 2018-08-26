#include <iostream.h>


int main() {

  char c;
  cout << "Enter one character> ";
  cout.flush();
  cin >> c;

  switch(c) {
     case 'a':
        cout << 'a';
     case 'b':
        cout << 'b';
     case 'c':
        cout << 'c';
     case 'd':
        cout << 'd';
     case 'e':
        cout << 'e';
     case 'f':
        cout << 'f';
     default:
        cout << '*';
  }

  cout << endl;

  return 0;
}
