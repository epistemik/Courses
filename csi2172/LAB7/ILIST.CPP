#pragma implementation
// FILE: ilist.cpp
// MODEL SOLUTION FOR ASSIGNMENT #2
//

#include <iostream.h>
#include "ilist.h"
#include <string.h>

ilist_exception::ilist_exception(const char* s) {
   // THROW EXCEPTION
   strcpy(error,s);
};

// DEFAULT CONS. CREATE EMPTY LIST
template<class T>
ilist<T>::ilist():first((ilist_node*)0),last((ilist_node*)0),
   last_accessed((ilist_node*)0),index(-1),l(0) {
};

// COPY CONSTRUCTOR: COPY ALL
template<class T>
ilist<T>::ilist(const ilist<T>& L):first((ilist_node*)0),last((ilist_node*)0),
   last_accessed((ilist_node*)0),index(-1),l(0) {
   copy(L);
};

// ASSIGNMENT OPERATOR: COPY ALL
template<class T>
ilist<T>& ilist<T>::operator=(const ilist<T>& L) {
   destroy();
   copy(L);
   return *this;
};

// DESTRUCTOR
template<class T>
ilist<T>::~ilist() {
   destroy();
};

template<class T>
void ilist<T>::destroy() {
   // DESTROY ALL NODES
   while(l>0) remove(0);
};

template<class T>
void ilist<T>::copy(const ilist<T>& L) {
   // CREATE AN ELEMENT-WISE CARBON COPY OF L
   ilist_node* ptr = L.first;
   while(ptr != (ilist_node*)0) {
      insert_after(l-1,ptr->elem);
      ptr = ptr->next;
   }
};

#define iabs(A) (A)<0 ? -(A) : (A)

template<class T>
void ilist<T>::find(int a) {

   // GIVEN INDEX a
   // MOVE LAST_ACCESSED TO POINT TO NODE WITH INDEX a
   if (a >= l || a < 0 ) {
      throw ilist_exception("over indexing");
   }

   // IF IT IS ALREADY THERE, DONE
   if (a == index) return;

   // SEE WHICH WAY IT IS FASTEST
   int d1 = a, d2 = index != -1 ? iabs(index - a) : l, d3 = l - a - 1;

   // MOVE LAST_ACCESSED TO THAT NODE
   last_accessed = d1 < d2 ? 
                      (d1 < d3 ? first
                              : last)
                           :
                      (d2 < d3 ? last_accessed
                              : last);

   // UPDATE INDEX TOO
   if (last_accessed == first) index = 0;
   if (last_accessed == last) index = l - 1;
       
                   
   // WHICH WAY DO I HAVE TO MOVE? 
   int incr = last_accessed == first ? 1
                           : last_accessed == last ? -1
                                         : index < a ? 1 : -1;

   // MOVE UNTIL YOU GET THERE
   while (a != index) {
      if (incr > 0) last_accessed = last_accessed->next; 
      else last_accessed = last_accessed->prev;
      index += incr;
   }

   // last_accessed is pointing to element with index a = index
};

//INSERT e AFTER INDEX a
template<class T>
void ilist<T>::insert_after(int a,const T& e) {

   // CREATE A NEW NODE WITH PREV AND NEXT 0x000
   // AND ELEMENT e
   ilist_node* node = new ilist_node;
   node->prev = node->next = (ilist_node*)0;
   node->elem = e;

   // SPECIAL CASE:
   // IF INDEX IS -1
   // THIS NODE BECOMES THE FIRST
   if (a == -1) {
      node->next = first;
      if (first != (ilist_node*)0) { // WASN'T EMPTY
         first->prev = node;
      } else { // WAS EMPTY
         last = node;
      }
      last_accessed = first = node;
      index = 0;
      l++;
      return; // DONE
   }

   // OTHERWISE MOVE last_accessed TO
   // POINT TO ELEMENT WITH INDEX a (index == a NOW!)
   find(a);

   // IF a == l-1 (IE INSERT AFTER LAST) THEN MOVE
   // last 
   if (a == l-1) last = node;
   l++;

   // ptr POINTS TO ELEMENT WITH INDEX a+1
   // OR NULL
   ilist_node* ptr = last_accessed->next;
  
   // HOOK UP THE LINKS 
   last_accessed->next = node;
   node->next = ptr;
   node->prev = last_accessed;
   if (ptr != (ilist_node*)0) ptr->prev = node;

   // LAST ACCESSED IS THIS NODE
   last_accessed = node;
   index++;
};


template<class T>
void ilist<T>::insert_before(int a,const T& e) {
   // CREATE A NEW NODE WITH PREV AND NEXT 0x000
   // AND ELEMENT e
   ilist_node* node = new ilist_node;
   node->prev = node->next = (ilist_node*)0;
   node->elem = e;

   // SPECIAL CASE: a == l 
   // INSERT BEFORE last+1
   if (a == l) {
      node->prev = last;
      if (last != (ilist_node*)0) { // WASN'T EMPTY
         last->next = node;
      } else { // WAS EMPTY
         first = node;
      }
      last_accessed = last = node;
      index = l;
      l++;
      return;
   }

   // OTHERWISE MOVE last_accessed TO
   // POINT TO ELEMENT WITH INDEX a (index == a NOW!)

   find(a);

   // IF a == 0 MOVE first
   if (a == 0)  first = node;

   l++;

   // a-1 ELEMENT OR NULL
   ilist_node* ptr = last_accessed->prev;
 
   // HOOK UP NODES 
   last_accessed->prev = node;
   node->next = last_accessed;
   node->prev = ptr;
   if (ptr != (ilist_node*)0) ptr->next = node;

   last_accessed = node;
};

template<class T>
void ilist<T>::remove(int a) {
   // MOVE TO ELEMENT WITH INDEX a
   find(a);

   // MEMORIZE ITS PREV AND NEXT
   ilist_node *prev = last_accessed->prev, *next = last_accessed->next;

   // GET RID OF IT
   delete last_accessed;
   last_accessed = (ilist_node*)0;

   l--;

   if (prev == (ilist_node*)0) { // WAS IT THE FIRST ?
      first = next;
   } else  {
      prev->next = next;
      last_accessed = next;
   }

   if (next == (ilist_node*)0) { // WAS IT THE LAST ?
      last = prev;
   } else {
      next->prev = prev;
      last_accessed = prev;
      index--;
   }

   // IF IT WAS THE ONLU ELEMENT
   if (last_accessed == (ilist_node*)0) index = -1; 
};

template<class T>
T& ilist<T>::operator[](int n) {
   // MOVE TO ELEMENT WITH INDEX n
   find(n);
   return last_accessed->elem;
};

template<class T>
int ilist<T>::length() const {
   return l;
};

template<class T>
void ilist<T>::debug() {
   ilist_node* ptr = first;

   cout << "FIRST: " << (void*)first 
        << " LAST: " << (void*)last
        << " LAST_ACC: " << (void*)last_accessed
        << " INDEX: " << index 
        << " L: " << l << ' ';

   while(ptr != (ilist_node*)0) {
      
      cout << '(' << (void*)ptr->prev << ')' 
           << '[' << '(' << (void*)ptr << ')' << ' ' << ptr->elem 
           << (last_accessed==ptr ? '*' : ' ') << ']' 
           << '(' << (void*)ptr->next << ')' << ' ';
      ptr = ptr->next;
   }

   cout << endl;
}


#include "ilist_inst.h"
 
