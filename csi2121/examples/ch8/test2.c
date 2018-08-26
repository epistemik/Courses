void testfunc(char a, char *b, char *c)
{}

void main()
{
  char i=1;
  char *p;
  p = &i;
  testfunc(i,&i,p);
}