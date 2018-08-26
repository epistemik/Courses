// File dynamic.cpp

#include <iostream.h>
#include <string.h>

#if !defined(__WIN32__)
extern "C"
	{
	#endif
	#include <stdlib.h>
	#if !defined(__WIN32__)
	}
#endif

int*** matrix3d(int h, int w, int d, int x = 0)
	// this function allocates an h x w x d 3-dimensional matrix and initializes the slots with x
{
   int*** a = new int**[h] ; 
   for ( int i = 0 ; i < h ; i++ ) 
   	{
      a[i] = new int*[w];
      for ( int j = 0 ; j < w ; j++ )
      	{
		a[i][j] = new int[d];
		for ( int k = 0 ; k < d ; k++ ) { a[i][j][k] = x ; } // initialize values to x 
		}
	}
   return a ;
}

void release3d(int*** m, int h, int w) 
   // release memory associated with m, which is a 3d array m[h][w][]
{
   for ( int i = 0 ; i < h ; i++ )
   	{
      for ( int j = 0 ; j < w ; j++ )	{ delete [] m[i][j] ; }
      delete [] m[i];
	}
   delete m;
}

int ** matrix2d(int w, int h, int x = 0) 
   // this function allocates a 2-dimensional array C style (not C++), and initializes the
   // elements to x
{
   int ** a = (int**) malloc( w * sizeof(int*) );
   for ( int i = 0 ; i < w ; i++ )
   	{
      a[i] = (int*) malloc( h * sizeof(int) );
      for ( int j = 0 ; j < h ; j++ ) { a[i][j] = x ; } // initialize values to x 
	}
   return a;
}

void release2d(int ** m, int w) 
   // release the 2d array m[w][] C style
{
   for ( int i = 0 ; i < w ; i++ ) { free(m[i]) ; }
   free(m) ;
}


int main() 
{
   char* name = "Santa Claus" ;
   cout << name << endl ;
  
   char buffer[256] ;
   cout << "enter your name > " ;
   cout.flush() ;
   cin >> buffer ;
  
   int n = strlen(buffer) ; 
   char* nb = new char[n+1] ; // why do I need + 1??
   
   for ( int i = 0 ; i < n ; i++ ) { nb[i] = buffer[n-i-1] ; }
   nb[n] = '\0';

   cout << "your name \"" << buffer << "\" backwards: \"" << nb << "\"" << endl ;
   delete [] nb ;

/* REMEMBER, C's  new, new[], delete and delete[] should not be used together with 
   C's malloc, calloc, realloc and free, unless you really know what you are doing.
   (see the note on page 37) */

   int *** m = matrix3d(2, 3, 2, 7) ;
   cout << "m[0][1][1] = " << m[0][1][1] << endl ;
   release3d(m, 2, 3) ;

   int ** k = matrix2d(3, 2, -2) ;
   cout << "k[2][0] = " << k[2][0] << endl ;
   release2d(k, 3) ;

   return 0 ;
}
