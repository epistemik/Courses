// qsort.h

#if !defined(_QSORT_H_)
#define _QSORT_H_

// PARAMETRIC QUICK SORT
// array: an array of elements of type T
// l:     start sorting at this index
// h:     sort up to and including this index
// f:     comparison function:  if it implements "less" then array is sorted in increasing order
//        							 if it implements "larger" then array is sorted in decreasing order


template<class T>
void quick_sort(T* array, int l, int h, bool (*f)(const T&, const T&)) 
{
   // base case, done
   if (l >= h) return ; 

   int i = l-1, j = h+1 ;

   // pivot value
   T cutoff = array[l] ;

   while(true) 
   {
     do	{
   		--j ;
   		} while( f(cutoff, array[j]) ) ;

     do 	{
     		++i ;
     		} while( f(array[i], cutoff) ) ;

     if (i<j) 
     		{
    		T tmp = array[i] ;
      	array[i] = array[j] ;
      	array[j] = tmp ; 
     		}
     	else break ;
   }

   quick_sort<T>(array, l, j, f) ;
   quick_sort<T>(array, j+1, h, f) ;
}

#endif
