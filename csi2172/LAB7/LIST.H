#pragma interface
#ifndef _LIST_H_
#define _LIST_H_

#ifndef NULL
#define NULL (list_node<T>*)0
#endif

// LIST NODES FOR
// DOUBLY LINKED LISTS
template<class T>
class list_node {
  public:
   // LINKS
   list_node<T>* next;  
   list_node<T>* prev; 
   T element;
   // CONSTRUCTOR
   list_node();
   // COPY CONSTRUCTOR
   list_node(const T&);
};

// LIST ITERATOR
template<class T>
class list_iterator {
  protected:
    // INTERNALLY A NODE POINTER
    list_node<T>* node;

  public:
    // CONSTRUCTOR
    list_iterator(list_node<T>* = NULL); 

    // IF TRUE, IT IS NOT NULL
    bool has_more_elements();

    // IF I IS A list_iterator THEN
    T& operator*();       // *I,
    T* operator->();      // I->
    T& operator++();      // ++I
    T& operator--();      // --I
    T& operator++(int);   // I++
    T& operator--(int);   // I--
    int operator==(const list_iterator<T>&); // EQUAL
    int operator!=(const list_iterator<T>&); // NOT EQUAL
    T& operator[](int);   // Nth ELEMENT
    list_iterator<T>  operator+(int) const; // I + n
    list_iterator<T>  operator-(int) const; // I - n
   
    list_node<T>* get_node();  // GET INTERNAL REP.
    void invalidate();        // SET TO NULL
};


// LIST CLASS
//
template<class T>
class list {

  protected:

     list_node<T>* _first;  // POINTER TO FIRST
     list_node<T>* _last;   // POINTER TO LAST
     int size;              // NUMBER OF ELEMENTS

     void copy(const list<T>&);
     void destroy(); 

  public: 
     // L.insert_before(I,n)
     // insert n before I
     void insert_before(list_iterator<T>,const T&);

     // L.insert_after(I,n)
     // insert n after I
     void insert_after(list_iterator<T>,const T&);

     // L.remove(I)
     // remove the element pointed to by I
     void remove(list_iterator<T>&);

     // I = L.first()
     // I is an iterator to the first element
     const list_iterator<T> first() const;

     // I = L.last()
     // I is an iterator to the last element
     const list_iterator<T> last() const;

     // L.length()
     // length of L
     int length() const;
 
     // CONSTRUCTOR 
     list();

     // COPY CONSTRUCTOR
     list(const list<T>&);

     // ASSIGNMENT OPERATOR
     list<T>& operator=(const list<T>&);

     // DESTRUCTOR
     virtual ~list();
};


#endif
