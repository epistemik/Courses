// aheap.cpp

#if defined(__GNUG__)
#pragma implementation
#endif

#include "aheap.h"


// A_NODE METHODS

template<class T>
array_heap<T>::a_node::a_node(const T& e, heap<T>::less& f, heap<T>::order& o, int pos):
	heap<T>::handle(f, o, e), ind(pos)
		{	}  // constructor

template<class T>
void array_heap<T>::a_node::swap(heap<T>::handle& h)
	{
	handle::swap(h) ;
	a_node& next = dynamic_cast<a_node&>(h) ;
	int temp = ind ; 
	ind = next.ind ;
	next.ind = temp ;
	} // swap()

template<class T>
array_heap<T>::a_node& array_heap<T>::a_node::operator=(const a_node& a)
	{
	ind = a.ind ;
	return *this ;
	} // op=


// ARRAY_HEAP METHODS

template<class T>
array_heap<T>::array_heap(less f, order o, int c): heap<T>(f, o), 
															 array(new a_node*[c]), max_size(c)
	{	} // constructor

template<class T>
array_heap<T>::array_heap(const array_heap<T>& H): heap<T>(H)
	{
	array = new a_node*[H.maxsize] ;
	for ( int i = 0 ; i < size() ; i++ )
//		array[i] = H.array[i] ;
		push(*H.array[i]) ; 
	maxsize = H.maxsize ;
	}  // copy constructor

template<class T>
array_heap<T>& array_heap<T>::operator=(const array_heap<T>& H)
	{
	heap<T>::operator=(H) ;
	for ( int i = 0 ; i < size() ; i++ )
		delete array[i] ;
	delete [] array ;
	array = new a_node*[H.maxsize] ;
	for ( int i = 0 ; i < size() ; i++ )
//		array[i] = H.array[i] ;
		push(*H.array[i]) ;
	maxsize = H.maxsize ;
	return *this;
	} // op=

template<class T>
array_heap<T>::~array_heap()
	{
	for ( int i = 0 ; i < size() ; i++ )
		delete array[i] ;
	delete [] array ;
	} // destructor

template<class T>
a_node array_heap<T>::left(a_node a) const
	{
	if ( empty() || ((a.ind+1)*2-1) > size() ) throw exception();
	return *array[(a.ind+1)*2-1] ;
	} // left()

template<class T>
a_node array_heap<T>::right(a_node a) const
	{
	if ( empty() || ((a.ind+1)*2) > size() ) throw exception();
	return *array[(a.ind+1)*2] ;
	} // right()

template<class T>
a_node array_heap<T>::parent(a_node a) const
	{
	if ( empty() || ((a.ind+1)/2-1) < 0 ) throw exception();
	return *array[(a.ind+1)/2-1] ;  // because C++ arrays are 0..(n-1)
	} // parent()

template<class T>
array_heap<T>::a_node  array_heap<T>::get_hp_child(array_heap<T>::a_node a)
	{
	if (right(a).ind > last()) return left(a) ;
	if (left(a).ind > last()) throw exception() ;
	if ( left(a).higher_priority(right(a)) )
		return left(a) ;
	else return right(a) ;
	} // get_hpc()

template<class T>
void array_heap<T>::sift_up(handle& h)
	{
	a_node& a = &static_cast<a_node&>(h) ; 
	int index = a.ind ;
	while( index != 0 )
   	{
      int parent = parent(a).ind ;
      if (*array[index].higher_priority(*array[parent]))
      	{
		swap(*array[index], *array[parent]) ; 
		index = parent ;
	      }
		else break ;
		}// re-index?
	} // sift_up

template<class T>
void array_heap<T>::sift_down(handle& h)
	{
	a_node& a = &static_cast<a_node&>(h) ; 

	int index = a.ind ;
	while(true)
     {
      if (left(a) >= size()) break ;
      int smaller ;
      if (right(a) >= size())
      	smaller = left(a).ind ;
      else
      	smaller = left(a).higher_priority(right(a) ?	left(a) : right(a) ;
      if (*array[smaller].higher_priority(*array[index]))
      	{
		swap(*array[smaller], *array[index]) ;
		index = smaller ;
	      }
		else  break;
		} // re-index?
	} // sift_down()

template<class T>
heap<T>::handle&  array_heap<T>::create_new(const T& e)
	{
	if (size() >= max_size) throw exception() ;
	array[size()] = new a_node(e, lt, ordering, size()) ;	
	return *array[size()] ;
	} // create_new(): ONLY used in push()

template<class T>
heap<T>::handle&  array_heap<T>::first()
	{
    if (empty()) throw exception() ;
	 return *array[0] ;
	} // first()

template<class T>
int array_heap<T>::last() const
	{
    if (empty() || size() > max_size) throw exception() ;
	 return (size()-1) ;
	} // last()

template<class T>
void array_heap<T>::move_last_to_first()
	{  swap(*array[0], *array[last()]) ;  } // move_last_to_first()

template<class T>
void array_heap<T>::delete_last()
	{
    if (empty()) throw exception() ;
    delete array[size()] ;
	} // delete_last(): ONLY used in pop()

template<class T>
heap<T>::handle&  array_heap<T>::index(const heap<T>::handle& h) const
	{
	const a_node& a = dynamic_cast<const a_node&>(h);
	return *a.ind ;
	} // index()

template<class T>
const T& array_heap<T>::top() const
	{
	if (empty()) throw exception();
	return *array[0];
	} // top()

template<class T>
void array_heap<T>::print(ostream& os, const array_heap<T>::a_node* n, int k = 0) const
	{
	for (int i = 0 ; i < k ; ++i)
		{ cout << "   " ; }
	if (n.ind < 0 || n.ind > size)
		{
		os << '.' << endl ;
		return ;
		}
	cout << **n << "   ( this=" << (void*)n << ", l=" << left(*n) << ", r=" << right(*n)
			<< ", u=" << up(*n) << ')' <<  endl ;

	print(os, left(*n), k+1) ;
	print(os, right(*n), k+1) ;
	} // print()

template<class T>
void array_heap<T>::print(ostream& os) const
	{
	os << "First = " << array[0] << "   Last = " << array[last()] << endl ;
	print(os, array[0]) ;
	} // print()
