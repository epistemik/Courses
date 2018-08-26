// daheap.cpp

#if defined(__GNUG__)
#pragma implementation
#endif

#include "daheap.h"

// DYNAMIC_ARRAY_HEAP METHODS

template<class T>
dynamic_array_heap<T>::dynamic_array_heap(less f, order o, int c): 
	heap<T>(f, o), array(new a_node*[c]), max_size(c)
	{	} // constructor

template<class T>
dynamic_array_heap<T>::dynamic_array_heap(const dynamic_array_heap<T>& H): 
	array_heap<T>(H)
	{
	array = new a_node*[H.maxsize] ;
	for ( int i = 0 ; i < H.size() ; i++ )
//		array[i] = H.array[i] ;
		push(**H.array[i]) ; 
	maxsize = H.maxsize ;
	}  // copy constructor

template<class T>
heap<T>::handle&  dynamic_array_heap<T>::create_new(const T& e)
	{
	if ( size() >= max_size ) 
		{
		a_node** new_array = new a_node*[max_size + 12] ;
		for ( int i = 0 ; i < size() ; i++ )
//			array[i] = H.array[i] ;
			new_array.push(**array[i]) ; 
		for ( int i = 0 ; i < size() ; i++ )
			delete array[i] ;
		delete [] array ;
		array = new_array ;
		max_size = max_size + 12 ;		
		}
	array[size()] = new a_node(e, lt, ordering, size()) ;	
	return *array[size()] ;
	} // create_new(): ONLY used in push()
