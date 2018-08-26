#pragma interface
// FILE: ilist.h
// MODEL SOLUTION FOR ASSIGNMENT #2
//

#if !defined(_ILIST_H_)
#define _ILIST_H_

// an instance of this class is
// thrown when a list exception occurs
struct ilist_exception {
    char error[256];
    ilist_exception(const char*);
};

/* INDEX LIST
 *
 * IMPLEMENTED AS A DOUBLY LINKED LIST
 * BUT PROVIDES RANDOM ACCESS
 *
 * INDEXED FROM 0-(l-1) WHERE l IS
 * THE LENGTH OF THE LIST
 *
 * OPERATIONS:
 *    insert_after(index,element)
 *       inserts element after index
 *       if index == -1, then element 
 *       becomes the first element
 *
 *    insert_before(index,element)
 *       inserts element before index
 *       if index == l, then element
 *       becomes the last element
 *
 *    remove(index)
 *       delete the element at index
 *
 *    [index]
 *       return a reference to the element
 *       held at index
 */
template<class T>
class ilist {

   private:

   // INTERNAL BUILDING BLOCK
   struct ilist_node {
      T elem;
      ilist_node * next;
      ilist_node * prev;
   };

      // FIRST 
      ilist_node * first;
      // LAST
      ilist_node * last;
      // LAST ACCESSED NODE
      ilist_node * last_accessed;
      // INDEX OF LAST ACCESSED NODE
      int index;
      // LENGTH OF LIST
      int l;

      void destroy();
      void copy(const ilist<T>&);

      // MOVE ELEMENT TO LAST ACCESSED NODE
      void find(int);

   public:
     
      // DEFAULT CONSTRUCTOR 
      ilist();
      // COPY CONSTRUCTOR 
      ilist(const ilist<T>&);
      // DESTRUCTOR
      ~ilist();
      // ASSIGNMENT OPERATOR
      ilist<T>& operator=(const ilist&);

      // L.insert_after(i,e)
      // e becomes element with index i+1
      void insert_after(int,const T&);

      // L.insert_before(i,e)
      // e becomes the new element with index i
      void insert_before(int,const T&);

      // L.remove(i)
      // remove element under index i
      void remove(int);

      // L[i]
      // return element under index i
      T& operator[](int);

      // return length of list
      int length() const;

      // a routine used to debug your code
      void debug();
};

   



#endif


