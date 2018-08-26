#pragma implementation

#include "list.h"

// constructor 
template<class T>
list_node<T>::list_node():next(NULL),prev(NULL) { };

// copy constructor
template<class T>
list_node<T>::list_node(const T& e):next(NULL),prev(NULL),element(e) { };

// constructor with node
template<class T>
list_iterator<T>::list_iterator(list_node<T>* n):node(n) {}

// is node pointing to an element?
template<class T>
bool list_iterator<T>::has_more_elements() {
  return node != NULL;
};

// list_iterator<T> I;
// if T is a struct or class
// T->field 
template<class T>
T* list_iterator<T>::operator->() {
  return &(node->element);
};


// list_iterator<T> I;
// *I, element I is pointing to
template<class T>
T& list_iterator<T>::operator*() {
  return node->element;
};

// ++I
template<class T>
T& list_iterator<T>::operator++() {
  node = node->next;
  return node->element;
};

// I++
template<class T>
T& list_iterator<T>::operator++(int) {
  T& remember = node->element;
  node = node->next;
  return remember;
};

// --I
template<class T>
T& list_iterator<T>::operator--() {
  node = node->prev;
  return node->element;
};

// I--
template<class T>
T& list_iterator<T>::operator--(int) {
  T& remember = node->element;
  node = node->prev;
  return remember;
};

// return internal rep., ie node
template<class T>
list_node<T>* list_iterator<T>::get_node() {
  return node;
};

// set pointer internally to NULL
template<class T>
void list_iterator<T>::invalidate() {
  node = NULL;
};

// equal
template<class T>
int list_iterator<T>::operator==(const list_iterator<T>& I) {
  return I.node == node;
};

// not equal
template<class T>
int list_iterator<T>::operator!=(const list_iterator<T>& I) {
  return ! ((*this) == I);
};

// I[n], (same as *(I+n)
// nth element
template<class T>
T& list_iterator<T>::operator[](int n) {
  return (*this + n).node->element;
};

// I + n
// iterator to nth element 
template<class T>
list_iterator<T>  list_iterator<T>::operator+(int n) const {
  if (n < 0) return operator-(-n);
  list_iterator<T> I;
  I.node = this->node;
  for(int i=0;i<n;i++) I++; 
  
  return I;   
};

// I - n
template<class T>
list_iterator<T>  list_iterator<T>::operator-(int n) const {
  if (n < 0) return operator+(-n);
  list_iterator<T> I;
  I.node = this->node;
  for(int i=0;i<n;i++) I--;
  
  return I;
};

// destroy elements between from and to
template<class T>
void list<T>::destroy() {
  list_node<T>* ptr = _first;

  while(ptr != NULL) {
    list_node<T>* next = ptr->next;
    delete ptr;
    ptr = next;
  } 

  size = 0;
};

// insert the nodes <from,to> from L2 after at and
// before at_nex
template<class T>
void list<T>::copy(const list<T>& L) {
   list_iterator<T> I = L.first();
   while(I.has_more_elements()) {
     insert_after(last(),*I);
     I++;
   }
};

// L.insert_before(I,n)
// insert n before I
template<class T>
void list<T>:: insert_before(list_iterator<T> I,const T& element) {
  list_node<T>* node = I.get_node();

  if (_first == NULL) {
     _first = new list_node<T>(element);
     size = 1;
     _last = _first;
     return;
  }

  if (node == NULL) return;

  list_node<T>* before = node->prev;

  size ++;

  if (before == NULL) {
    _first = new list_node<T>(element);
    _first->next = node;
    node->prev = _first;
    return;
  }

  before->next = new list_node<T>(element);
  before->next->next = node;
  before->next->prev = node->prev;
  node->prev = before->next;
};


// L.insert_after(I,n)
// insert n after I
template<class T>
void list<T>::insert_after(list_iterator<T> I,const T& element) {
  list_node<T> *node = I.get_node();

  if (_first == NULL) {
     _first = new list_node<T>(element);
     size = 1;
     _last = _first;
     return;
  }

  if (node == NULL) return;

  list_node<T>* after = node->next;

  size ++;

  if (after == NULL) {
    _last = new list_node<T>(element);
    _last->prev = node;
    node->next = _last;
    return;
  }

  node->next = new list_node<T>(element);
  node->next->prev = node;		
  node->next->next = after;
  after->prev = node->next;
};

// L.remove(I)
// remove the element pointed to by I
template<class T>
void list<T>::remove(list_iterator<T>& I) {
  list_node<T>* n = I.get_node();
  
  if (n==NULL) return;

  list_node<T>* after  = n->next;
  list_node<T>* before = n->prev;

  if (before == NULL) {
    _first = after;
  } else {
    before->next = after;
  }
 
  if (after == NULL) {
    _last = before;
  } else {
    after->prev = before;
  }

  size--;

  delete n;

  I.invalidate();
};

template<class T>
const list_iterator<T> list<T>::first() const {
  list_iterator<T> I(_first);
  return I;
};

template<class T>
const list_iterator<T> list<T>::last() const {
  list_iterator<T> I(_last);
  return I;
};

template<class T>
int list<T>::length() const { return size; };


template<class T>
list<T>::list() :_first(NULL),_last(NULL),size(0) {
};

template<class T>
list<T>::list(const list<T>& L):_first(NULL),_last(NULL),size(0) {
  copy(L);
};

template<class T>
list<T>::~list(){
  destroy();
};

template<class T>
list<T>& list<T>::operator=(const list<T>& L) {
  destroy();
  copy(L);
  return *this;
};

#include "list_inst.h"
