void testfunc()
{
}

void myfunc(void (*func_ptr)())
{
   (*func_ptr)();
   return;
}

void main(void)
{
   void (*func_ptr)() = testfunc;
   myfunc(func_ptr);
}


