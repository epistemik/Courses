// lheap.h

#if defined(__GNUG__)
#pragma interface
#endif

#if !defined(_LINKED_HEAP_H_) 
#define _LINKED_HEAP_H_

#include "heap.h"
#include <iostream.h>

/*** heap implemented as a linked heap
  **
  ** the heap interface is not modified and not extended
  **/
template<class T>
class linked_heap: public heap<T> 
{
  private:
       /*** subclass of heap<T>::handle
        ** 
        ** it inherits elem, and the unique id mechanism
        **/
      class node: public handle 
      {
         public:
           node* left;
           node* right;
           node* up;

           // index
           mutable node* _index;

           node(const T&, heap<T>::less&, heap<T>::order&);
           void swap(handle&);
      }; // class linked_heap::node

      // pointer to top element 
      node* _first;

      // pointer to last inserted element
      node* _last;

      // find where the previous element was inserted
      // this would be a piece of cake for array 
      node* prev();

      // find where the next element should be added
      // this would be a piece of cake for array 
      node* next();

      // create deep copy recursivelly
      void copy(node*);

      // destroy recursivelly below node
      void destroy(node*);
 
      // return the child with higher priority
      node* get_higher_priority_child(node*);

      // print everything below node
      void print(ostream&, const node*, int = 0) const;


  protected:
      // see heap.h
      // pure virtual methods implemented
      //
      void sift_up(handle&);
      void sift_down(handle&);
      handle& create_new(const T&);
      handle& first();
      void move_last_to_first();
      void delete_last();
      handle& index(const handle&) const;

  
  public:
      // usual constructor and destructor business
      linked_heap(less,order);
      linked_heap(const linked_heap<T>&);
      linked_heap<T>& operator=(const linked_heap<T>&);
      ~linked_heap();

      // used for debugging
      void print(ostream&) const;

      const T& top() const;
};

#endif
