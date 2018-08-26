Program a5 ;

USES  QueueADT ;

const  MAX = 10000 ;
		D1_MAX = 999 ;
		D2_MAX = 12 ;
		FLAG = -99 ; 

type	Key = integer ;
		ArrayIndex = 1..MAX ;
		SortingArray = array[ArrayIndex] of Key ;
		RadixArray = array[0..D1_MAX, 1..D2_MAX] of Key ;

var	BigVal, RootKey: Key ;
		A: SortingArray ; {Array to sort}
		n, temp,             	{Number of elements in array}
		Largest, 
		choice,     			{User input}
		i, j, j2, j3, k, k2, k3, l,           {counters}
		t,               			{Number of trials}
		correct: integer;   {Number of correct runs}
		Qarray : array[0..19] of Queue ;
		QarrM : array[0..999] of Queue ;
		QarrC : array[0..32] of Queue ;
		OverFlow, Finished : boolean ;
		Darray : RadixArray ;

{*********************************** QUICK SORT **********************************}

{ Partition(A,i,j)
	preconditions: A is an array, and [i..j] is a range of values to be partitioned
	postconditions: A[i..j] has been partitioned using the Partition algorithm found in program 13.15 }
procedure Partition(var A: SortingArray; var i, j: ArrayIndex);
var
	Pivot : Key;
begin
	Pivot := A[(i+j) div 2];
	repeat
		while A[i] < Pivot do inc(i) ;
		while A[j] > Pivot do dec(j) ;
		if i <= j then begin
			temp := A[i]; A[i] := A[j]; A[j] := temp ;
			inc(i) ;
			dec(j)
			END; { if }
	until i > j
end; { proc Partition }

{ QuickSort(A,m,n)
	preconditions: A is an array, and [m..n] is a range of values to be sorted
	postconditions: A[m..n] has been sorted using the QuickSort algorithm found in program 13.14 }
procedure QuickSort(var A: SortingArray; m, n: ArrayIndex);
var
	i, j : ArrayIndex ;
begin
	if ( m < n ) then begin
		i := m; j := n;
		Partition(A, i, j);
		QuickSort(A, m, j);
		QuickSort(A, i, n)
		END { if }
end; { proc QuickSort }

{************************************* RADIX SORT *************************************}

{ Power(x, n)
  preconditions: x and n are integers
  postconditions: returns x^n 
HINT: you may need this when you are isolating the digits in RadixSort }
function power(x, n: integer): integer;
var
	i, result : integer;
begin
	result := 1;
	for i := 1 to n do result := result * x ;
	power := result
end; { fxn Power }

{*********************************** EXTRA STUFF **********************************}

function Random(var seed: integer): real ;
const
	MODULUS = 35537 ;
	MULTIPLIER = 27193 ;
	INCREMENT = 13849 ;
begin	Random := ((MULTIPLIER * seed) + INCREMENT) {mod MODULUS} end; 

{ MakeRandomArray(A,n)
	preconditions: n is the size of array to create
	postconditions: A[1..n] has been initialized with random numbers in the range 1..MAXINT }
procedure MakeRandomArray(var A: SortingArray; n: ArrayIndex);
var
	i, m : integer ;
begin
	for i := 1 to n do begin
		m := i + n ; { MAXINT - sqr(i + n) mod sqr(n) ;}
		A[i] := trunc( {MAXINT *} Random(m) ) ;
		A[i] := Abs( A[i] )
		end
end;

{ PrintArray(A,n)
	preconditions: A is an array of size n
	postconditions: A[1..n] is printed to the screen }
procedure PrintArray(var A: SortingArray; N: ArrayIndex);
const
	ROWSIZE = 11 ;
var
	j, k, size: ArrayIndex ;
begin
	for j := 1 to ( N div ROWSIZE + 1 ) do BEGIN
		if ( j * ROWSIZE ) <= N then
			size := ROWSIZE
		else
			size := N - ( ( j - 1 ) * ROWSIZE ) ;
		writeln ;
		for k := 1 to size do
			write( A[( j - 1 ) * ROWSIZE + k]:6 ) ;
		if size > 0 then writeln
		END; { for }
	if ( N mod ROWSIZE <> 0 ) then writeln
end; { proc PrintArray }

{ IsSorted(A,n)
	preconditions: A is an array of size n
	postconditions: Returns TRUE if A[1..n] is sorted in ascending order.  Returns FALSE otherwise }
function IsSorted(var A: SortingArray; n: ArrayIndex): boolean;
var i : ArrayIndex ;
begin
	IsSorted := TRUE;
	for i := 2 to n do
		if ( A[i] < A[i - 1] ) then 
			begin IsSorted := FALSE; exit(IsSorted) end
end;

{********************************** MAIN ************************************}

begin
   repeat
      writeln;
      writeln(' 1. HeapSort an Array                 7. Test HeapSort');
      writeln(' 2. QuickSort an Array                8. Test QuickSort');
      writeln(' 3. SelectionSort an Array            9. Test SelectionSort');
      writeln(' 4. RadixSort an Array               10. Test RadixSort');
      writeln(' 5. BigRadixSort an Array            11. Test BigRadixSort');
      writeln(' 6. ArrayRadixSort an Array          12. Test ArrayRadixSort');
      writeln('99. QUIT');
      writeln; readln(choice);

      case choice of
      1,2,3,4,5,6 : begin
            writeln('This option creates a random array and sorts it');
            writeln;
            write('How many elements in the array? '); readln(n);
            MakeRandomArray(A,n);
            writeln; writeln( 'The random array: ' );
            if ( n <= 300 ) then PrintArray(A, n)
            	else begin writeln( '*** way too BIG to print ***' ); writeln end;
            writeln( 'Press Enter to sort...' ); readln;
            case choice of
	            1: begin
				for i := (n div 2) downto 2 do begin
					k3 := i ;
					RootKey := A[k3];
					j := 2 * k3 ;
					Finished := ( j > n ) ;
					while not Finished do begin
						if ( j < n ) then
							if ( A[j+1] > A[j] ) then inc(j) ;
						if A[j] <= RootKey then
							Finished := TRUE
						else begin
							A[k3] := A[j] ;
							k3 := j ;
							j := 2 * k3 ;
							Finished := ( j > n)
							end { else }
						END; { while }
					A[k3] := RootKey
					end; { for - SiftUp }
				for i := n downto 2 do begin
					k2 := i ;
					RootKey := A[k2];
					j := 2 * k2 ;
					Finished := ( j > n ) ;
					while not Finished do begin
						if ( j < n ) then if ( A[j+1] > A[j] ) then inc(j) ;
						if A[j] <= RootKey then Finished := TRUE
						else begin
							A[k2] := A[j] ;
							k2 := j ;
							j := 2 * k2 ;
							Finished := ( j > n)
							end { else }
						END; { while }
					A[k2] := RootKey ;
					temp := A[k2] ;
					A[k2] := A[j] ;
					A[j] := temp ;
				end; { for - SiftUp & Swap }
			end; { case HeapSort }

	            2: QuickSort(A,1,n) ;

	            3: begin
				for j := n downto 2 do begin
					BigVal := A[1] ;
					Largest := 1 ;
					for k := 2 to j do
						if ( A[k] > BigVal ) then begin
							BigVal := A[k] ;
							Largest := k
							END; { if } 
					temp := A[Largest] ;
					A[Largest] := A[j] ;
					A[j] := temp ;
					END;  { for }
				end; { case - SelectionSort }

	            4: begin
				for j := 0 to 19 do CreateQ(Qarray[j]) ;
				for j := 1 to n do Enq(Qarray[A[j] mod 10], A[j]) ;
				for i := 1 to 4 do begin
					k := 0 ;
					for j := 0 to 9 do begin
						l := j ;
						if ( i mod 2 = 0 ) then l := j + 10 else k := 10 ;
						while not IsEmptyQ( Qarray[l] ) do begin 
							temp := Deq(Qarray[l]) ;
							Enq(Qarray[temp div Power(10, i) mod 10 + k], temp)
							END  { while }
						END;  { for j }
					END;  { for i }
				k := 1 ;
				for j := 0 to 3 do
					while not IsEmptyQ( Qarray[j] ) do begin 
						A[k] := Deq(Qarray[j]) ;
						inc(k) ;
						END  { while }
				end; { case RadixSort }

	            5: begin
				for j := 0 to 999 do CreateQ(QarrM[j]) ;
				for j := 0 to 32 do CreateQ(QarrC[j]) ;
				for j := 1 to n do Enq(QarrM[A[j] mod 1000], A[j]) ;
				for j := 0 to 999 do
					while not IsEmptyQ( QarrM[j] ) do begin 
						temp := Deq(QarrM[j]) ;
						Enq(QarrC[temp div 1000], temp)
						END;  { while }
				k := 1 ;
				for j := 0 to 32 do
					while not IsEmptyQ( QarrC[j] ) do begin 
						A[k] := Deq(QarrC[j]) ;
						inc(k) ;
						END  { while }
				end; { case BigRadixSort }

	            6: begin
				for j := 0 to D1_MAX do for k := 1 to D2_MAX do Darray[j, k] := FLAG ;
				for j := 1 to n do begin
						j2 := A[j] mod 1000 ;
						k := 1 ;
						OverFlow := FALSE ;
						while ( Darray[j2, k] <> FLAG ) & ( k <= D2_MAX ) do inc(k) ;
						if k > D2_MAX then
							Overflow := TRUE
						else 
							Darray[j2, k] := A[j]
						end; { for - Load }
				if OverFlow then writeln( 'Warning: array 1 overflow !!' ) ;

				k := 1 ;
				for j := 0 to D1_MAX do
					for k2 := 1 to D2_MAX do
						if ( Darray[j, k2] <> FLAG ) then begin 
							k3 := 1 ;
							while ( Darray[j, k3] = FLAG ) & ( k3 <= D2_MAX ) do inc(k3) ;
							if k3 <= D2_MAX then begin
								A[k] := Darray[j, k] ;
								Darray[j, k] := FLAG 
								END  { if }
							else A[k] := FLAG ;
							inc(k) ;
						end ; { if }
				if k < n then writeln( 'Warning: loss of data at stage 1: k = ', k, ';  n = ', n, ' !!' ) ;
			  
				for j := 1 to n do begin
					j2 := A[j] div 100 ;
					k := 1 ;
					OverFlow := FALSE ;
					while ( Darray[j2, k] <> FLAG ) & ( k <= D2_MAX ) do inc(k) ;
					if k > D2_MAX then
						Overflow := TRUE
					else 
						Darray[j2, k] := A[j]
					end; { for - Load }
				if OverFlow then writeln( 'Warning: array 2 overflow !!' ) ;

				k := 1 ;
				for j := 0 to D1_MAX do
					for k2 := 1 to D2_MAX do
						if ( Darray[j, k2] <> FLAG ) then begin 
							k3 := 1 ;
							while ( Darray[j, k3] = FLAG ) & ( k3 <= D2_MAX ) do inc(k3) ;
							if k3 <= D2_MAX then begin
								A[k] := Darray[j, k] ;
								Darray[j, k] := FLAG 
								END  { if }
							else A[k] := FLAG ;
							inc(k) ;
						end ; { if }
				if  (k < n) then writeln( 'Warning: loss of data at stage 2: k = ', k, ';  n = ', n, ' !!' ) ;
			end; { proc ArrayRadixSort }
		end; { case choice }

            writeln( 'The SORTED array: ' );
            if ( n <= 300 ) then PrintArray(A,n)
            	else begin writeln( '*** way too BIG to print ***' ); writeln end;
            writeln( ' "IsSorted" returned ',  IsSorted(A,n) ) ;
            writeln( '-----------------------------' ) ;
	end; { 1,2,3,4,5,6 }

      7,8,9,10,11,12 : begin
            writeln( 'This option tests a sorting algorithm on a bunch of arrays.' ); writeln;
            write('How many elements in each array? '); readln(n);
            write('How many tests do you want to do? '); readln(t);
            correct := 0;
            for j3 := 1 to t do begin
               MakeRandomArray(A,n);
               case choice of
                  7:  begin
				for i := (n div 2) downto 2 do begin
					k3 := i ;
					RootKey := A[k3];
					j := 2 * k3 ;
					Finished := ( j > n ) ;
					while not Finished do begin
						if ( j < n ) then if ( A[j+1] > A[j] ) then inc(j) ;
						if A[j] <= RootKey then Finished := TRUE
						else begin
							A[k3] := A[j] ;
							k3 := j ;
							j := 2 * k3 ;
							Finished := ( j > n)
							end { else }
						END; { while }
					A[i] := RootKey
					end; { for - SiftUp }
				for i := n downto 2 do begin
					k2 := i ;
					RootKey := A[k2];
					j := 2 * k2 ;
					Finished := ( j > n ) ;
					while not Finished do begin
						if ( j < n ) then if ( A[j+1] > A[j] ) then inc(j) ;
						if A[j] <= RootKey then Finished := TRUE
						else begin
							A[k2] := A[j] ;
							k2 := j ;
							j := 2 * k2 ;
							Finished := ( j > n)
							end { else }
						END; { while }
					A[k2] := RootKey ;
					temp := A[k2] ;
					A[k2] := A[j] ;
					A[j] := temp ;
				end; { for - SiftUp & Swap }
			end; { case HeapSort }

                  8: QuickSort(A,1,n) ;
                  
                  9: 	begin
				for j := n downto 2 do begin
					BigVal := A[1] ;
					Largest := 1 ;
					for k := 2 to j do
						if ( A[k] > BigVal ) then begin
							BigVal := A[k] ;
							Largest := k
							END; { if } 
					temp := A[Largest] ;
					A[Largest] := A[j] ;
					A[j] := temp ;
					end;  { for }
				end; { case - SelectionSort }

                 10:  begin
				for j := 0 to 19 do CreateQ(Qarray[j]) ;
				for j := 1 to n do Enq(Qarray[A[j] mod 10], A[j]) ;
				for i := 1 to 4 do begin
					k := 0 ;
					for j := 0 to 9 do begin
						l := j ;
						if ( i mod 2 = 0 ) then l := j + 10 else k := 10 ;
						while not IsEmptyQ( Qarray[l] ) do begin 
							temp := Deq(Qarray[l]) ;
							Enq(Qarray[temp div Power(10, i) mod 10 + k], temp)
							END  { while }
						END;  { for j }
					END;  { for i }
				k := 1 ;
				for j := 0 to 3 do
					while not IsEmptyQ( Qarray[j] ) do begin 
						A[k] := Deq(Qarray[j]) ;
						inc(k) ;
						END  { while }
				end; { case RadixSort }

                 11: begin
				for j := 0 to 999 do CreateQ(QarrM[j]) ;
				for j := 0 to 32 do CreateQ(QarrC[j]) ;
				for j := 1 to n do Enq(QarrM[A[j] mod 1000], A[j]) ;
				for j := 0 to 999 do
					while not IsEmptyQ( QarrM[j] ) do begin 
						temp := Deq(QarrM[j]) ;
						Enq(QarrC[temp div 1000], temp)
						END;  { while }
				k := 1 ;
				for j := 0 to 32 do
					while not IsEmptyQ( QarrC[j] ) do begin 
						A[k] := Deq(QarrC[j]) ;
						inc(k) ;
						END  { while }
				end; { case BigRadixSort }

                 12: begin
				for j := 0 to D1_MAX do for k := 1 to D2_MAX do Darray[j, k] := FLAG ;
				for j := 1 to n do begin
					j2 := A[j] mod 1000 ;
					k := 1 ;
					OverFlow := FALSE ;
					while ( Darray[j2, k] <> FLAG ) & ( k <= D2_MAX ) do inc(k) ;
					if k > D2_MAX then
						Overflow := TRUE
					else 
						Darray[j2, k] := A[j]
					end; { for - Load }
				if OverFlow then writeln(  'Warning: array 1 overflow !!' ) ;

				k := 1 ;
				for j := 0 to D1_MAX do
					for k2 := 1 to D2_MAX do
						if ( Darray[j, k2] <> FLAG ) then begin 
							k3 := 1 ;
							while ( Darray[j, k3] = FLAG ) & ( k3 <= D2_MAX ) do inc(k3) ;
							if k3 <= D2_MAX then begin
								A[k] := Darray[j, k] ;
								Darray[j, k] := FLAG 
								END  { if }
							else A[k] := FLAG ;
							inc(k) ;
						end ; { if }
				if k < n then writeln(  'Warning: loss of data at stage 1: k = ', k, ';  n = ', n, ' !!' ) ;
			  
				for j := 1 to n do begin
					j2 := A[j] div 100 ;
					k := 1 ;
					OverFlow := FALSE ;
					while ( Darray[j2, k] <> FLAG ) & ( k <= D2_MAX ) do inc(k) ;
					if k > D2_MAX then
						Overflow := TRUE
					else 
						Darray[j2, k] := A[j]
					end; { for - Load }
				if OverFlow then writeln(  'Warning: array 2 overflow !!' ) ;

				k := 1 ;
				for j := 0 to D1_MAX do
					for k2 := 1 to D2_MAX do
						if ( Darray[j, k2] <> FLAG ) then begin 
							k3 := 1 ;
							while ( Darray[j, k3] = FLAG ) & ( k3 <= D2_MAX ) do inc(k3) ;
							if k3 <= D2_MAX then begin
								A[k] := Darray[j, k] ;
								Darray[j, k] := FLAG 
								END  { if }
							else A[k] := FLAG ;
							inc(k) ;
						end ; { if }
				if (k < n) then writeln(  'Warning: loss of data at stage 2: k = ', k, ';  n = ', n, ' !!' ) ;
			end; { proc ArrayRadixSort }
		end; { case choice }

            if ( IsSorted(A,n) ) then correct := correct + 1;
            end; { for }
         writeln; writeln('IsSorted returned TRUE ', correct, ' times in ', t, ' trials.');
         writeln( '------------------------------------------------' ) ;
	end; { 7,8,9,10,11,12 }
	
   end; { case choice }
	
   until (choice = 99);
   if not MemCheck then writeln( 'Error: Memory Leak!' ) ;
   writeln( 'PROGRAM ENDED - have a nice life!' ) ;
end.
