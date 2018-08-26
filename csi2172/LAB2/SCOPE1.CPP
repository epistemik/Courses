extern int a;     // a must be defined in another file
                  // the linker must find it

static int b = 4; // this variable is local to this file

extern void print(int);
                  // this function must be defined
                  // somewhere else

int main() {

  print(a);
  print(b);
  {
    int a = 3;   // local to this block
    print(a);
    print(::a);  // "global" a
  }

  return 0;
}

