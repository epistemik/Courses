// sheap.cpp : array heap implementation

#include <stdlib.h>
#include <iostream.h>
#include <console.h>

class sheap 
{
   private:
       int capacity ;
       int* array ;
       int size ;

       void sift_up(int) ;
       void sift_down(int) ;

   public:
      sheap(int = 100) ;
      ~sheap() ;
      sheap(const sheap&) ;
      sheap& operator = (const sheap&) ;

      void push(int) ;
      int top() const ;
      void pop() ;

      int size() const ;

      void print() const ;
}; // declarations


// IMPLEMENTATION

sheap::sheap(int c): capacity(c), array(new int[c]), size(0) 
	{	}

sheap::~sheap() 
	{  delete [] array ;  }


sheap::sheap(const sheap& H): capacity(H.capacity), array(new int[H.capacity]), size(H.size) 
	{
	for(int i = 0 ; i < size ; ++i) 
		array[i] = H.array[i] ;
	} // copy constructor


sheap& sheap:: operator=(const sheap& H) 
	{
	   delete [] array;
	   capacity = H.capacity ;
	   array = new int[capacity] ;
	   size = H.size ;

	   for(int i = 0 ; i < size ; ++i) 
	   	array[i] = H.array[i] ;
	   
	   return *this ;
	} // op=


void sheap::sift_up(int index) 
{
   while( index != 0 ) 
   	{
      int parent = (index+1)/2 - 1;  // becuase C++ arrays are 0..(n-1)
 
      if (array[parent] > array[index]) 
      	{
	         int tmp = array[index];
	         array[index] = array[parent];
	         array[parent] = tmp;
	         index = parent;
	      } 
	else break;
	}
} // sift_up()


void sheap::sift_down(int index) 
{
   while(true) 
   {
      int left_child = (index+1)*2 - 1,
            right_child = (index+1)*2 + 1 - 1;
      // don't worry, the compiler will simplify them

      if (left_child >= size)  	break;
 
      int smaller_child;

      if (right_child >= size) 
      	smaller_child = left_child;
      else
      	smaller_child = array[right_child] < array[left_child] ? right_child : left_child;

      if (array[smaller_child] < array[index]) 
      	{
	         int tmp = array[index];
	         array[index] = array[smaller_child];
	         array[smaller_child] = tmp;
	         index = smaller_child;
	      }
	else  break;
	}
} // sift_down()


void sheap::push(int a) 
{
   if (size >= capacity) throw "heap overflow";

   array[size] = a;
   ++size;

   sift_up(size-1);
} // push()


int sheap::top() const 
{
   if (n == 0) throw "empty heap";
   return array[0];
} // top()


void sheap::pop() 
{
   if (size == 0) throw "empty heap";
   --size;
   array[0] = array[size];
   sift_down(0);
} // pop()


int sheap::size() const
	{  return size ;  }


void sheap::print() const 
{
   for(int i = 0 ; i < size ; ++i) 
   	 cout << array[i] << ' ';
   cout << endl;
} // print()


int main(int argc, char* argv[]) 
{
  sheap H;

  argc = ccommand(&argv) ;
  
  for(int i = 1 ; i < argc ; ++i) 
   	H.push(atoi(argv[i]));

  while(H.size() > 0) 
   	{
      cout << H.top() << ' ';
      H.pop();
   	}

  cout << endl;

  return 0;
}
