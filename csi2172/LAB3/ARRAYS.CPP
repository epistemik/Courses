// File arrays.cpp

#include <iostream.h>

void print_vector1(int v[2]) 
{   
   cout << "v1 = {" ;

   for ( int i = 0 ; i < 2 ; i++ ) { cout << v[i] << ( i == 1 ? '}' : ',' ) ; }
   cout << endl ;
}

void print_vector2(int v[], int l) 
{   
   cout << "v2 = {" ;

   for ( int i = 0 ; i < l ; i++ ) { cout << v[i] << ( i == (l-1) ? '}' : ',' ) ; }
   cout << endl ;
}

void print_vector3(int *v, int l) 
{
   cout << "v3 = {" ;

   for ( int i = 0 ; i < l ; i++ ) { cout << v[i] << ( i == (l-1) ? '}' : ',' ) ; }
   cout << endl ;
}

void print_matrix1(int m[3][2]) 
{
   cout << "m1 = { ";
   for ( int i = 0 ; i < 3 ; i++ )
   	{
      cout << '{' ;
      for ( int j = 0 ; j < 2 ; j++ ) { cout << m[i][j] << ( j == 0 ? ',' : '}' ) ; }
      cout << ( i == 2 ? " }" : ", " ) ;
   	}
   cout << endl ;  
}

void print_matrix2(int m[][2], int r) 
{
   cout << "m2 = { ";
   for ( int i = 0 ; i < r ; i++ )
   	{
      cout << '{' ;
      for ( int j = 0 ; j < 2 ; j++ ) { cout << m[i][j] << ( j == 0 ? ',' : '}' ) ; }
      cout << ( i == (r-1) ? " }" : ", " ) ;
	}
   cout << endl ; 
}

void print_matrix3(int *m[], int r) // same as 'void print_matrix3(int *m[2], int r)'
{
   cout << "m3 = { ";
   for ( int i = 0 ; i < r ; i++ ) 
   	{
      cout << '{' ;
      for ( int j = 0 ; j < 2 ; j++ ) { cout << m[i][j] << ( j == 0 ? ',' : '}' ) ; }
      cout << ( i == (r-1) ? " }" : ", " ) ;
	}
   cout << endl ; 
}

void print_matrix4(int **m, int r, int c) 
{
   cout << "m4 = { ";
   for ( int i = 0 ; i < r ; i++ )
   	{
      cout << '{' ;
      for ( int j = 0 ; j < c ; j++ ) { cout << m[i][j] << ( j == (c-1) ? '}' : ',' ) ; }
      cout << ( i == (r-1) ? " }" : ", " );
	}
   cout << endl ; 
}

int main()
{
   int vector1[2] = { 1, 2 };

   int matrix1[3][2] =
   {
       { 11, 12 },
       { 21, 22 },
       { 31, 32 }
   };

   int vector2[] = { 3, 4 };

   int matrix2[][2] = 
   {
       { 41, 42 },
       { 51, 52 },
       { 61, 62 }
   };

   int ** matrix3;

   matrix3 = new int*[3];
   for (int i = 0; i < 3; i++)
   	{
      matrix3[i] = new int[2] ;
      for ( int j = 0 ; j < 2 ; j++ ) { matrix3[i][j] = 70*(i+1) + (j+1) ; } 
	}
 
   print_vector1(vector1); 
   print_vector1(vector2); 
   print_vector2(vector1, 2); 
   print_vector2(vector2, 2); 
   print_vector3(vector1, 2); 
   print_vector3(vector2, 2); 

   print_matrix1(matrix1);
   print_matrix2(matrix1, 3);
   // print_matrix3(matrix1,3);  // int [3][2] cannot be int **
   // print_matrix4(matrix1,3,2);  // int [3][2] cannot be int **

   print_matrix1(matrix2);
   print_matrix2(matrix2, 3);
   // print_matrix3(matrix2,3); // int (*)[2] cannot be int **
   // print_matrix4(matrix2,3,2); // int (*)[2] cannot be int **

   // print_matrix1(matrix3); // int ** cannot be int [3][2]
   // print_matrix2(matrix3,3); // int ** cannot be int (*)[2]
   print_matrix3(matrix3, 3);
   print_matrix4(matrix3, 3, 2); 

   print_vector1(matrix1[0]);
   print_vector1(matrix2[0]);
   print_vector1(matrix3[0]);

   print_vector2(matrix1[0], 2);
   print_vector2(matrix2[0], 2);
   print_vector2(matrix3[0], 2);

   print_vector3(matrix1[0], 2);
   print_vector3(matrix2[0], 2);
   print_vector3(matrix3[0], 2);

   return 0;
}
