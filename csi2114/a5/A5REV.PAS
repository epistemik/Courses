Program a5;

uses QueueADT ;

const MAX = 10000 ;

type
	KeyType = integer ;
	ArrayIndex = 1..MAX ;
	SortingArray = array[ArrayIndex] of KeyType ;

(******************************* SELECTION SORT ***********************************)

procedure Swap(var i, j: KeyType) ;
var
	temp : Keytype ;
begin
	temp := i ;
	i := j ;
	j := temp ;
end; { proc Swap }

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

(************************************ HEAP SORT ***********************************)

(* SiftUp(A,i,n)
   preconditions: A is an array, [i..n] is the range to be reheapified.
   postconditions: A[i..n] has been reheapified using the SiftUp algorithm found in program
13.10 *)

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

(* HeapSort(A,n)
   preconditions: A is an array of size n storing values of type KeyType
   postconditions: A has been sorted using the HeapSort algorithm found in program 13.10 *)

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

(************************************ QUICK SORT ***********************************)

(* Partition(A,i,j)
   preconditions: A is an array, and [i..j] is a range of values to be partitioned
   postconditions: A[i..j] has been partitioned using the Partition algorithm found in program
13.15 *)

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

(* QuickSort(A,m,n)
   preconditions: A is an array, and [m..n] is a range of values to be sorted
   postconditions: A[m..n] has been sorted using the QuickSort algorithm found in program
13.14 *)

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

(************************************ RADIX SORT ***********************************)

(* Power(x, n)
  preconditions: x and n are integers
  postconditions: returns x^n 
HINT: you may need this when you are isolating the digits in RadixSort *)
function power(x, n: integer): integer;
var
	i, result : integer;
begin
	result := 1;
	for i := 1 to n do
		result := result * x ;
	power := result
end; { fxn Power }

(* RadixSort(A,n)
   preconditions: A is an array of size n
   postconditions: A[1..n] has been sorted using the RadixSort algorithm *)

procedure RadixSort(var A: SortingArray; n: ArrayIndex);
var
	temp : KeyType ;
	i, j, k, l : ArrayIndex ; { loop indices }
	Qarray : array[0..19] of Queue ;
begin
	for j := 0 to 19 do
		CreateQ(Qarray[j]) ;
	
	for j := 1 to n do 
		Enq(Qarray[A[j] mod 10], A[j]) ;
		
{*}	for j := 0 to 9 do begin write( 'Qarray[', j, '] :  ' ); PrintQ(Qarray[j]) end ;

	for i := 1 to 4 do
		BEGIN
{*}		writeln( 'i = ', i ) ;
		k := 0 ;
		for j := 0 to 9 do
			BEGIN
			l := j ;
			if ( i mod 2 = 0 ) then l := j + 10 else k := 10 ;
			while not IsEmpty( Qarray[l] ) do 
				BEGIN 
				temp := Deq(Qarray[l]) ;
				Enq(Qarray[temp div Power(10, i) mod 10 + k], temp)
				END  { while }
			END;  { for j }
{*}		for j := 0 to 19 do begin write( 'Qarray[', j, '] :  ' ); PrintQ(Qarray[j]) end ;
{*}		readln ;
		END;  { for i }

	k := 1 ;
	for j := 0 to 9 do
		BEGIN
		while not IsEmpty( Qarray[j] ) do 
			BEGIN 
			A[k] := Deq(Qarray[j]) ;
			inc(k) ;
			END  { while }
		END;  { for j }

{	for j := 0 to 19 do
		DestroyQ(Qarray[j]) ;
}
	if not MemCheck then writeln( 'Error: Memory Leak: ', memcount ) ;
	
end; { proc RadixSort }

(************************************ EXTRA STUFF ***********************************)

function Random(var seed: integer): real ;
const
	MODULUS = 35537 ;
	MULTIPLIER = 27193 ;
	INCREMENT = 13849 ;
begin
	Random := ((MULTIPLIER * seed) + INCREMENT) mod MODULUS ;
end; 

(* MakeRandomArray(A,n)
   preconditions: n is the size of array to create
   postconditions: A[1..n] has been initialized with random numbers in the range 1..MAXINT *)

procedure MakeRandomArray(var A: SortingArray; n: ArrayIndex);
var i : ArrayIndex ;
begin
   for i := 1 to n do begin
      A[i] := trunc( MAXINT * Random(i) ) ;
      A[i] := Abs( A[i] )
      end
end;

(* PrintArray(A,n)
   preconditions: A is an array of size n
   postconditions: A[1..n] is printed to the screen *)

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

(* IsSorted(A,n)
   preconditions: A is an array of size n
   postconditions: Returns TRUE if A[1..n] is sorted in ascending order.  Returns FALSE otherwise *)

function IsSorted(var A: SortingArray; n: ArrayIndex): boolean;
var i : ArrayIndex ;
begin
  IsSorted := TRUE;
  for i := 2 to n do
     if ( A[i] < A[i - 1] ) then 
     		begin IsSorted := FALSE; exit(IsSorted) end
end;

(*********************************** MAIN *************************************)

var
  A: SortingArray; {Array to sort}
  n,              {Number of elements in array}
  choice,       {User input}
  i,               {counter}
  t,               {Number of trials}
  correct: integer;   {Number of correct runs}

begin
   repeat
      writeln;
      writeln('1. HeapSort an Array,');
      writeln('2. QuickSort an Array,');
      writeln('3. SelectionSort an Array,');
      writeln('4. RadixSort an Array,');
      writeln('5. Test HeapSort,');
      writeln('6. Test QuickSort,');
      writeln('7. Test SelectionSort,');
      writeln('8. Test RadixSort,');
      writeln('9. quit');
      writeln; readln(choice);

      case choice of
         1,2,3,4 : begin
            Writeln('This option creates a random array and sorts it');
            Writeln;
            Write('How many elements in the array?'); readln(n);
            MakeRandomArray(A,n);
            Writeln; Writeln( 'The random array: ' );
            if ( n <= 300 ) then
               PrintArray(A,n)
            else
               Writeln( '*** too BIG to print ***' );
            Writeln;
            Write( 'Press Enter to sort' );
            readln;
            case choice of
               1: HeapSort(A,n) ;
               2: QuickSort(A,1,n) ;
               3: SelectionSort(A,n) ;
               4: RadixSort(A,n) ;
            end; { case }
            writeln; Writeln( 'The sorted array: ' );
            if ( n <= 300 ) then
               PrintArray(A,n)
            else
               Writeln( '*** too BIG to print ***' );
            Writeln;
    		Write( ' "IsSorted" returned ',  IsSorted(A,n) ) ;
            readln;
         end; { 1,2,3,4 }

         5,6,7,8 : begin
            Writeln( 'This option tests a sorting algorithm on a bunch of arrays.' );
            Writeln;
            Write('How many elements in each array?'); readln(n);
            Write('How many tests do you want to do?'); readln(t);
            correct := 0;
            for i := 1 to t do begin
               MakeRandomArray(A,n);
               case choice of
                  5: HeapSort(A,n) ;
                  6: QuickSort(A,1,n) ;
                  7: SelectionSort(A,n) ;
                  8: RadixSort(A,n) ;
               end; { case }
               if ( IsSorted(A,n) ) then correct := correct + 1;
               end; { for }
           	writeln;
            writeln('IsSorted returned TRUE ', correct, ' times in ', t, ' trials.');
            readln;
         end; { 5,6,7,8 }

      end; { case choice }

   until (choice = 9);
end.
