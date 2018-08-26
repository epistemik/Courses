// daheap.h

#if defined(__GNUG__)
#pragma interface
#endif

#if !defined(_DA_HEAP_H_) 
#define _DA_HEAP_H_

#include "heap.h"
#include "aheap.h"
#include <iostream.h>

/* aheap implemented as a dynamic array		*/
template<class T>
class dynamic_array_heap: public array_heap<T>
{
  protected:
      handle& create_new(const T&) ;

  public:

  
      // constructor
      dynamic_array_heap(less, order, int=12) ;
	// copy constructor
	dynamic_array_heap(const dynamic_array_heap<T>&) ;
};

#endif
