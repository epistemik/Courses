Program a5 ;

uses QueueADT ;

{ Increase the stack to run ArrayRadixSort }
{$M 49000, 0, 655360}

const  MAX = 10000 ;
{ Constants for ArrayRadixSort }
     D1_MAX = 999 ;
     D2_MAX = 23 ;
     FLAG = -99 ;
     ARRAY_MAX = 4000 ;

type
  KeyType = integer ;
  ArrayIndex = 1..MAX ;
  SortingArray = array[ArrayIndex] of KeyType ;
  RadixArray = array[0..D1_MAX, 1..D2_MAX] of KeyType ;


{****************************** SELECTION SORT **********************************}

{ Swap the values of two variables }
procedure Swap(var i, j: KeyType) ;
var
  temp : Keytype ;
begin
  temp := i ;
  i := j ;
  j := temp ;
end; { proc Swap }


{ Find the index for the largest value in an array }
function Largest(A: SortingArray; i, j: ArrayIndex): ArrayIndex ;
var
  k : ArrayIndex ;
  BigVal : KeyType ;
begin
  BigVal := A[i] ;
  Largest := i ;
  if ( i < j ) then for k := (i + 1) to j do
    if ( A[k] > BigVal ) then
     BEGIN
     BigVal := A[k] ;
     Largest := k
     END { if } 
end; { fxn Largest }
{ A Selection Sort algorithm to compare with the others }
procedure SelectionSort(var S: SortingArray; n: integer) ;
var
  j, k : ArrayIndex ;
begin
  for j := n downto 2 do
    BEGIN
    k := Largest(S, 1, j) ;
    Swap(S[k], S[j])
    END { for }
end; { proc SelectionSort }


{*********************************** HEAP SORT **********************************}

{ SiftUp(A,i,n)
   preconditions: A is an array, [i..n] is the range to be reheapified.
   postconditions: A[i..n] has been reheapified using the SiftUp algorithm found in program
13.10 }

procedure SiftUp(var A: SortingArray; i, n: ArrayIndex);
var
  j: ArrayIndex;
  RootKey: KeyType;
  Finished: Boolean;
begin
  RootKey := A[i];
  j := 2 * i ;
  Finished := ( j > n ) ;
  
  while not Finished do
    BEGIN
    if ( j < n ) then
     if ( A[j+1] > A[j] ) then inc(j) ;
  
    if A[j] <= RootKey then
     Finished := TRUE
    else
     begin
     A[i] := A[j] ;
     i := j ;
     j := 2 * i ;
     Finished := ( j > n)
     end { else }
    END; { while }
  
  A[i] := RootKey
end; { proc SiftUp }

{ HeapSort(A,n)
   preconditions: A is an array of size n storing values of type KeyType
   postconditions: A has been sorted using the HeapSort algorithm found in program 13.10 }

procedure HeapSort(var A: SortingArray; n: ArrayIndex);
var
  i : ArrayIndex ;
begin
  for i := (n div 2) downto 2 do SiftUp(A, i, n);
  for i := n downto 2 do begin
    SiftUp(A, 1, i) ;
    Swap(A[1], A[i]) ;
    end { for }
end; { proc HeapSort }

{*********************************** QUICK SORT **********************************}

{ Partition(A,i,j)
   preconditions: A is an array, and [i..j] is a range of values to be partitioned
   postconditions: A[i..j] has been partitioned using the Partition algorithm found in program
13.15 }

procedure Partition(var A: SortingArray; var i, j: ArrayIndex);
var
  Pivot : KeyType;
begin
  Pivot := A[(i+j) div 2];
  repeat
    while A[i] < Pivot do inc(i) ;
    while A[j] > Pivot do dec(j) ;
    if i <= j then begin
     Swap(A[i], A[j]) ;
     inc(i) ;
     dec(j)
     end; { if }
  until i > j
end; { proc Partition }


{ QuickSort(A,m,n)
   preconditions: A is an array, and [m..n] is a range of values to be sorted
   postconditions: A[m..n] has been sorted using the QuickSort algorithm found in program
13.14 }

procedure QuickSort(var A: SortingArray; m, n: ArrayIndex);
var
  i, j : ArrayIndex ;
begin
  if ( m < n ) then begin
    i := m; j := n;
    Partition(A, i, j);
    QuickSort(A, m, j);
    QuickSort(A, i, n)
    end { if }
end; { proc QuickSort }

{*********************************** RADIX SORT **********************************}

{ Power(x, n)
  preconditions: x and n are integers
  postconditions: returns x^n 
HINT: you may need this when you are isolating the digits in RadixSort }
function power(x, n: integer): integer;
var
  i, result : integer;
begin
  result := 1;
  for i := 1 to n do
    result := result * x ;
  power := result
end; { fxn Power }

{ RadixSort(A,n)
   preconditions: A is an array of size n
   postconditions: A[1..n] has been sorted using the RadixSort algorithm }

procedure RadixSort(var A: SortingArray; n: ArrayIndex);
var
  temp : KeyType ;  { for temporary storage of an array value }
  i, j, k, l : integer ;  { loop indices }
  Qarray : array[0..19] of Queue ;  { array to store the sorted elements in the pass for each digit }
begin
  { initialize the array }
  for j := 0 to 19 do
    CreateQ(Qarray[j]) ;

  { Load the SortingArray in the array of queues by sorting on the low digit }
  for j := 1 to n do 
    Enq(Qarray[A[j] mod 10], A[j]) ;

  { Start a loop to process each other digit of the KeyType integers and store the sorted results in the
  upper or lower part of the array of queues }
  for i := 1 to 4 do
    BEGIN
    k := 0 ;
  { A second loop to process the queue for each digit 0-9, for each pass of the outer loop }
    for j := 0 to 9 do

     BEGIN
    { Need a secondary variable as can't directly alter the loop index j }
     l := j ;
    { Add 10 to either j or k depending on the value of i - to move the sorted array values from the top of
    the array of queues to the bottom or vice versa }
     if ( i mod 2 = 0 ) then l := j + 10 else k := 10 ;
     while not IsEmpty( Qarray[l] ) do 
       BEGIN 
    { Get the value from the sorted array of queues }
       temp := Deq(Qarray[l]) ;
    { Sort on the next digit and assign to the empty half of the array of queues }
       Enq(Qarray[temp div Power(10, i) mod 10 + k], temp)
       END  { while }
     END;  { for j }
    END;  { for i }

  { Start the index for reloading SortingArray A }
  k := 1 ;
  { Start a loop to move the values from the final sorted array of queues back into SortingArray A } 
  for j := 0 to 3 do
    while not IsEmpty( Qarray[j] ) do 
     BEGIN 
     A[k] := Deq(Qarray[j]) ;
     inc(k) ;
     END  { while }

end; { proc RadixSort }

{ ================================================ }

{ A radix sort that uses bigger arrays of queues and has two passes - sorting on the 3 low digits in the first
pass and the 2 high digits in the second pass }
procedure BigRadixSort(var A: SortingArray; n: ArrayIndex);
var
  temp : KeyType ;
  j, k : integer ; { loop indices }
  QarrM : array[0..999] of Queue ;
  QarrC : array[0..32] of Queue ;
begin
  for j := 0 to 999 do CreateQ(QarrM[j]) ;
  for j := 0 to 32 do CreateQ(QarrC[j]) ;

  for j := 1 to n do Enq(QarrM[A[j] mod 1000], A[j]) ;

  for j := 0 to 999 do
    while not IsEmpty( QarrM[j] ) do begin
     temp := Deq(QarrM[j]) ;
     Enq(QarrC[temp div 1000], temp)
     END;  { while }

  k := 1 ;
  for j := 0 to 32 do
    while not IsEmpty( QarrC[j] ) do begin
     A[k] := Deq(QarrC[j]) ;
     inc(k) ;
     END  { while }

end; { proc BigRadixSort }

{ ================================================ }

{ A radix sort that uses 2D arrays of integers to store the sorted passes instead of arrays of queues - if
these 2D arrays are too big the stack capacity is exceeded, and there is a limit to the size of the stack for a
sub-procedure, so there is a lower maximum limit to the size of the original array that can be sorted by this
method. }
procedure ArrayRadixSort(var A: SortingArray; var n: ArrayIndex);

    { Private procedure to load values into a row of a 2D array }
     procedure Load(var L: RadixArray; J: ArrayIndex; V: KeyType; var OverFlow: boolean ) ;
     var  k : ArrayIndex ;
     begin
       k := 1 ;
       OverFlow := FALSE ;
       while (L[j, k] <> FLAG) and (k <= D2_MAX) do inc(k) ;
        if k > D2_MAX then
          Overflow := TRUE
       else
          L[j, k] := V
     end; { priv proc Load }

    { Private procedure to read and delete values from a row of a 2D array }
     function Take(var T: RadixArray; J: ArrayIndex): KeyType ;
     var k: integer ;
     begin
       k := 1 ;
       while (T[j, k] = FLAG) and (k <= D2_MAX) do inc(k) ;
       if k <= D2_MAX then begin
        Take := T[j, k] ;
        T[j, k] := FLAG
        END
       else take := FLAG
     end; { priv fxn Take }

    { Private procedure to check if a row of a 2D array is empty of KeyType values }
     function Is_empty(var E: RadixArray; J: ArrayIndex ): Boolean ;
     var  k : ArrayIndex ;
     begin
       Is_empty := TRUE ;
       for k := 1 to D2_MAX do
        if ( E[j, k] <> FLAG ) then begin
          Is_empty := FALSE ;
          exit; end
     end; { priv fxn Is_empty }

var
  OverFlow : boolean ;
  temp : KeyType ;
  j, k : integer ;
  Darray : RadixArray ;
begin
  if n > ARRAY_MAX then begin
     n := ARRAY_MAX ;
     writeln( '>>Note: Maximum array size for ArrayRadixSort is ', ARRAY_MAX, '!' )
     END;

  for j := 0 to D1_MAX do for k := 1 to D2_MAX do Darray[j, k] := FLAG ;

  for j := 1 to n do Load( Darray,  A[j] mod 1000, A[j], OverFlow ) ;
  if OverFlow then writeln( 'Warning: array 1 overflow !!' ) ;

  k := 1 ;
  for j := 0 to D1_MAX do
    while not Is_empty( Darray, j ) do begin
     A[k] := Take( Darray, j ) ;
     inc(k) ;
     END;  { while }
  if k < n then writeln( 'Warning: loss of data at stage 1: k = ', k, '; n = ', n, ' !!' ) ;

  for j := 1 to n do Load( Darray,  A[j] div 100, A[j], OverFlow ) ;
  if OverFlow then writeln( 'Warning: array 2 overflow !!' ) ;

  k := 1 ;
  for j := 0 to D1_MAX do
    while not Is_empty( Darray, j ) do begin
     A[k] := Take( Darray, j ) ;
     inc(k) ;
     END;  { while }
  if k < n then writeln( 'Warning: loss of data at stage 2: k = ', k, '; n = ', n, ' !!' ) ;

end; { proc ArrayRadixSort }
{*********************************** EXTRA STUFF **********************************}

{ MakeRandomArray(A,n)
   preconditions: n is the size of array to create
   postconditions: A[1..n] has been initialized with random numbers in the range 1..MAXINT }

procedure MakeRandomArray(var A: SortingArray; n: ArrayIndex);
var i : ArrayIndex ;
begin
   for i := 1 to n do
      A[i] := Random(MAXINT)
end;

{ PrintArray(A,n)
   preconditions: A is an array of size n
   postconditions: A[1..n] is printed to the screen }

procedure PrintArray(var A: SortingArray; N: ArrayIndex);
var
  j, k, size: ArrayIndex ;
begin
  for j := 1 to ( N div 11 )+1 do
    BEGIN
    if ( j * 11 ) <= N then
     size := 11
    else
     size := N - ( ( j - 1 ) * 11 ) ;
    writeln ;
    for k := 1 to size do
     write( A[( j - 1 ) * 11 + k]:6 ) ;
    writeln
    END { for }
end; { proc PrintArray }

{ IsSorted(A,n)
   preconditions: A is an array of size n
   postconditions: Returns TRUE if A[1..n] is sorted in ascending order.  Returns FALSE
otherwise }

function IsSorted(var A: SortingArray; n: ArrayIndex): boolean;
var i : ArrayIndex ;
begin
  IsSorted := TRUE;
  for i := 2 to n do
     if ( A[i] < A[i - 1] ) then 
        begin IsSorted := FALSE; exit; end
end;

{********************************** MAIN ************************************}

var
  A: SortingArray; {Array to sort}
  n: ArrayIndex;   {Number of elements in array}
  choice,          {User input}
  i,               {counter}
  t,               {Number of trials}
  correct: integer;   {Number of correct runs}

begin
   repeat
      writeln;
      writeln('1. HeapSort an Array                 7. Test HeapSort');
      writeln('2. QuickSort an Array                8. Test QuickSort');
      writeln('3. SelectionSort an Array            9. Test SelectionSort');
      writeln('4. RadixSort an Array               10. Test RadixSort');
      writeln('5. BigRadixSort an Array            11. Test BigRadixSort,');
      writeln;
      writeln('6. ArrayRadixSort an Array          12. Test ArrayRadixSort,');
      writeln(' >>>> Max ', ARRAY_MAX, ' elements for ArrayRadixSort !! <<');
      writeln;
      writeln('99. QUIT');
      writeln; readln(choice);

      case choice of
         1,2,3,4,5,6 : begin
            Writeln('This option creates a random array and sorts it.');
            Writeln;
            Write('How many elements in the array? '); readln(n);
            MakeRandomArray(A,n);
            Writeln; Writeln( 'The random array: ' );
            if ( n <= 300 ) then
               PrintArray(A,n)
            else
               Writeln( '*** too BIG to print ***' );
            Writeln;
            Writeln( 'Press Enter to sort' );
            readln;
            case choice of
               1: HeapSort(A,n) ;
               2: QuickSort(A,1,n) ;
               3: SelectionSort(A,n) ;
               4: RadixSort(A,n) ;
               5: BigRadixSort(A,n) ;
               6: ArrayRadixSort(A,n) ;
            end; { case }
            writeln; Writeln( 'The sorted array: ' );
            if ( n <= 300 ) then
               PrintArray(A,n)
            else
               Writeln( '*** too BIG to print ***' );
            Writeln;
            Writeln( ' "IsSorted" returned ',  IsSorted(A,n), '!' ) ;
        end; { 1,2,3,4,5,6 }

         7,8,9,10,11,12 : begin
            Writeln( 'This option tests a sorting algorithm on a bunch of arrays.' );
            Writeln;
            Write('How many elements in each array? '); readln(n);
            Write('How many tests do you want to do? '); readln(t);
            correct := 0;
            for i := 1 to t do begin
               MakeRandomArray(A,n);
               case choice of
                  7: HeapSort(A,n) ;
                  8: QuickSort(A,1,n) ;
                  9: SelectionSort(A,n) ;
                 10: RadixSort(A,n) ;
                 11: BigRadixSort(A,n) ;
                 12: ArrayRadixSort(A,n) ;
               end; { case }
               if ( IsSorted(A,n) ) then correct := correct + 1;
               end; { for }
             writeln;
            writeln('IsSorted returned TRUE ', correct, ' times in ', t, ' trials.');
        end; { 7,8,9,10,11,12 }

      end; { case choice }

   until (choice = 99);
   if not MemCheck then writeln( 'Error: MEMORY LEAK!' ) ;
   writeln( 'PROGRAM ENDED - have a nice summer.' ) ;
end.
