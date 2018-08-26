// lheap.cpp

#if defined(__GNUG__)
#pragma implementation
#endif

#include "lheap.h"

template<class T>
linked_heap<T>::node::node(const T& e, heap<T>::less& f, heap<T>::order& o):
	heap<T>::handle(f, o, e), left(0), right(0), up(0), _index(this) 
		{	}

template<class T>
void linked_heap<T>::node::swap(heap<T>::handle& h) 
	{
	handle::swap(h) ;
	node& n = dynamic_cast<node&>(h) ;
	node* tmp = _index ; 
	_index = n._index ;
	n._index = tmp ;
	} // node::swap()


template<class T>
linked_heap<T>::node* linked_heap<T>::prev() 
	{
	if (_last == _first) 
		return _first;

	node* ptr = _last;

	if (ptr->up->right==ptr) 
		return ptr->up->left;	// 50 % of cases are trivial

	while(ptr->up != 0  &&  ptr->up->left == ptr)
		ptr=ptr->up; 	// go up while left
	     
	if (ptr==_first)  // if top reached go down as far right as possible
		{
		while(ptr->right != 0) 
			ptr=ptr->right ;
		return ptr ;
		}

	ptr=ptr->up->left ;	// jump to sibling

	while(ptr->right!=0) ptr=ptr->right ; 	// go to the far right

	return ptr;
	} // prev()


template<class T>
linked_heap<T>::node* linked_heap<T>::next() 
	{
	if (_first == 0) return 0;  // empty

	if (_first->left == 0  ||  _first->right == 0)
		return _first;	// singleton

	node* ptr=_last;

	if (ptr->up->right == 0) 
		return ptr->up ;	// 50 % of all cases are trivial
	

	while(ptr->up != 0) 	// go up while right
		{
		if (ptr->up->right==ptr) ptr=ptr->up ;
		else break ;
		}

	if (ptr == _first) 	// if top reached go left as possible
		{
		while(ptr->left != 0)
			ptr=ptr->left ;
		return ptr ;
		}

	ptr = ptr->up->right ;	// jump to sibling
	
	while(ptr->left != 0)	// go to the far left
		ptr = ptr->left ;

	return ptr;
	} // next()


template<class T>
void linked_heap<T>::copy(linked_heap<T>::node* n) 
	{
	if (n==0) return ;
	push(**n) ;
	copy(n->left) ;
	copy(n->right) ;
	} // copy()


template<class T>
void linked_heap<T>::destroy(linked_heap<T>::node* n) 
	{
	if (n==0) return ;

	destroy(n->left) ;
	destroy(n->right) ;

	delete n ;
	number_of_elements = 0 ;
	} // destroy()


template<class T>
linked_heap<T>::node* linked_heap<T>::get_higher_priority_child(linked_heap<T>::node* n) 
	{
	// if (n == 0) return 0;
	if (n->left == 0) return n->right ;
	if (n->right == 0) return n->left ;

	if (n->left->higher_priority(*(n->right))) 
		return n->left ;
	else return n->right ;
	} // get_hpc()


template<class T>
void linked_heap<T>::sift_up(handle& h) 
	{
	node* ptr = &static_cast<node&>(h) ; 

	while (ptr->up!=0) 
		{
		if (ptr->higher_priority(*(ptr->up))) // element out of order
			{
			ptr->swap(*(ptr->up)) ;
			ptr = ptr->up ;
			}
		else return ; 
		}
	} // sift_up


template<class T>
void linked_heap<T>::sift_down(handle& h) 
	{
	node* ptr = &static_cast<node&>(h), *child ;

	while ((child = get_higher_priority_child(ptr))!=0) 
		{
		if ( child->higher_priority(*ptr)) // compare element to larger child
			{
			child->swap(*ptr);
			ptr = child;
			}
		else return;
		} 
	} // sift_down()


template<class T>
heap<T>::handle& linked_heap<T>::create_new(const T& e) 
	{
	node* ptr = next() ;

	node* n = new node(e,lt,ordering) ;
	n->left = n->right = 0 ;
	n->up = ptr ;

	if (ptr == 0) 
		_last = _first = n ;
	else 
		{
		if (ptr->left == 0) 
			_last = ptr->left = n ;
		else if (ptr->right == 0) 
				_last = ptr->right = n ;
		}
	return *n ;
	} // create_new()


template<class T>
heap<T>::handle& linked_heap<T>::first() 
	{
	if (empty()) throw exception();
	return *_first;
	} // first()


template<class T>
void linked_heap<T>::move_last_to_first() 
	{  _first->swap(*_last);  }


template<class T>
void linked_heap<T>::delete_last() 
	{
	node* ptr = _last ;
	_last = prev() ;

	if (ptr->up != 0) 
		{
		if (ptr->up->right == ptr) 
			ptr->up->right=0 ;
		else
			ptr->up->left = 0 ;
		}
	else 
		_last = _first=0 ;
		
	delete ptr;
	} // delete_last()


template<class T>
heap<T>::handle& linked_heap<T>::index(const heap<T>::handle& h) const
	{
	const node& n = dynamic_cast<const node&>(h);
	return *n._index;
	} // index()


template<class T>
const T& linked_heap<T>::top() const 
	{
	if (empty()) throw exception();
	return **_first;
	} // top()


template<class T>
linked_heap<T>::linked_heap(less f,order o): heap<T>(f,o), _first(0), _last(0) 
	{	}


template<class T>
linked_heap<T>::linked_heap(const linked_heap<T>& H): heap<T>(H), _first(0), _last(0) 
	{  copy(H._first);  }


template<class T>
linked_heap<T>& linked_heap<T>::operator=(const linked_heap<T>& H) 
	{
	heap<T>::operator=(H);
	destroy(_first);

	copy(H._first);
	return *this;
	} // op=


template<class T>
linked_heap<T>::~linked_heap() 
	{  destroy(_first);  }


template<class T>
void linked_heap<T>::print(ostream& os, const linked_heap<T>::node* n, int k = 0) const 
	{
	for(int i = 0 ; i < k ; ++i) 
		{ cout << "   " ; }

	if (n == 0) 
		{ 
		os << '.' << endl ;
		return ;
		}

	cout << **n << "   ( this=" << (void*)n << ", l=" << n->left << ", r=" 
			<< n->right << ", u=" << n->up << ')' <<  endl ;

	print(os, n->left, k+1) ;
	print(os, n->right, k+1) ;
	} // print()


template<class T>
void linked_heap<T>::print(ostream& os) const 
	{
	os << "_first = " << _first << "  _last = " << _last << endl ;
	print(os, _first) ;
	} // print()
