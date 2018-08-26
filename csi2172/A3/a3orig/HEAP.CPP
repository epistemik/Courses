// heap.cpp

#if defined(__GNUG__)
#pragma implementation
#endif

#include "heap.h"


// used to generate the unique ids
template<class T>
long heap<T>::handle::last_id = 0 ;


// handle's constructor
template<class T>
heap<T>::handle::handle(heap<T>::less& f, heap<T>::order& o, const T& e):
	id(++last_id), lt(f), ordering(o), elem(e)
	{	}


// returns true if 'this' is higher priority than h
template<class T>
bool heap<T>::handle::higher_priority(const heap<T>::handle& h) 
	{
	if (ordering == heap<T>::SMALLER_FIRST) 
		{
		if (lt(h.elem,elem)) return false;
		if (lt(elem,h.elem)) return true;
		return id < h.id; 
		}
	else if (ordering == heap<T>::LARGER_FIRST) 
		{
		if (lt(elem,h.elem)) return false;
		if (lt(h.elem,elem)) return true;
		return id < h.id;
		}
		else throw exception();
	} // handle::higher_priority()


// swap 'this' and handle
//
// IMPORTANT: id is a private instance variable,
// hence subclasses of handle who overload this
// method should explicitly invoke this method like
//
//    handle::swap(h)
//
// and do not forget that elem is swapped here!
template<class T>
void heap<T>::handle::swap(heap<T>::handle& h)
	{
	  long tmpi = id;
	  id = h.id;
	  h.id = tmpi;

	  T tmpe = elem;
	  elem = h.elem;
	  h.elem = tmpe;
	} // handle::swap()


// returns the element associated with handle
template<class T>
const T& heap<T>::handle::operator*() const
{  return elem ;  }


// heap constructor
template<class T>
heap<T>::heap(heap<T>::less f, heap<T>::order o): lt(f), number_of_elements(0),ordering(o)
	{	}


// virtual destructor because of polymorphism
template<class T>
heap<T>::~heap() 
	{	}


// the push operation
// most probably does not have to be overloaded in the subclass
//
// IMPORTANT: push increments the number of elements
// so create_new shouldn't !!!
template<class T>
heap<T>::handle& heap<T>::push(const T& e) 
	{ 
	handle& h = create_new(e);
	++number_of_elements;
	sift_up(h);
	return h;
	} // push()


// notify the heap that the element with handle
// h may have had its priority changed!
template<class T>
void heap<T>::priority_change(handle& h) 
	{
	sift_up(index(h)); // does nothing if priority is lower
	sift_down(index(h)); // does nothing if priority is higher
	} // priority_change


// the pop operation
// most probably does not have to be overloaded
// in the subclass
//
// IMPORTANT: pop decrements the number of elements
// so delete_last shouldn't !!!
template<class T>
void heap<T>::pop() 
	{
	   if (empty()) throw exception();

	   move_last_to_first();
	   delete_last();
	   --number_of_elements;
	   if (!empty()) sift_down(first());
	} // pop()


// return if heap is empty
template<class T>
bool heap<T>::empty() const 
	{  return number_of_elements == 0 ;  }


// return the number of elements
template<class T>
int heap<T>::size() const 
	{  return number_of_elements ;  }
