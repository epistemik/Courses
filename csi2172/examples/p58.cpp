//FILE: p58.cpp
//NAME: Mark Sattolo

#include <iostream>

const short int DEPTH = 3 ;
const short int HEIGHT = 5 ;
const short int WIDTH = 4 ;

void main()
  {
	short int ***a ; // a 3 x 5 x 4 array
   a = new short int**[DEPTH] ; // depth
   for( int i=0; i<DEPTH; i++ )
     {
      a[i] = new short int*[HEIGHT] ; // height
      for( int j=0; j<HEIGHT; j++ )
         a[i][j] = new short int[WIDTH] ; // width
     }

   // set the values
   for( int i=0; i<DEPTH; i++ )
      for( int j=0; j<HEIGHT; j++ )
         for( int k=0; k<WIDTH; k++ )
            a[i][j][k] = i*j*k ;

	cout << " a == " << a << " at " << &a << endl ;

   for( int i=0; i<DEPTH; i++ )
	   cout << " a[" << i << "] == " << a[i] << " at " << &a[i] << endl ;

   for( int i=0; i<DEPTH; i++ )
      for( int j=0; j<HEIGHT; j++ )
        {
         cout << " a[" << i << "][" << j << "] == " << a[i][j] ;
         cout << " at " << &a[i][j] << endl ;
        }

   for( int i=0; i<DEPTH; i++ )
      for( int j=0; j<HEIGHT; j++ )
         for( int k=0; k<WIDTH; k++ )
           {
            cout << " a[" << i << "][" << j << "][" << k << "] == " ;
            cout << a[i][j][k] << " at " << &a[i][j][k] << endl ;
           }

   for( int i=0; i<DEPTH; i++ )
     {
      for( int j=0; j<HEIGHT; j++ )
         delete [] a[i][j] ;
      delete [] a[i] ;
     }

   delete [] a ;   
  }
// main()