Program a5;

{ This program compares sorting methods.  
   Your job is to fill in code for the Radix Sort procedure below}

uses QueueADT;

const MAX = 10000;

type
	KeyType = integer;
	ArrayIndex = 1..MAX;
	SortingArray = array[ArrayIndex] of KeyType;

(************************************ HEAP SORT ***********************************)

(* SiftUp(A,i,n)
   preconditions: A is an array, [i..n] is the range to be reheapified.
   postconditions: A[i..n] has been reheapified using the SiftUp algorithm found in program 13.10 *)

procedure SiftUp(var A: SortingArray; i,n: integer);
var
	j: ArrayIndex;
	RootKey: KeyType;
	NotFinished: Boolean;
begin
	RootKey := A[i];
	j := 2*i;
	NotFinished := (j<=n);
	while NotFinished do
		begin
		if j<n then
			if A[j+1]>A[j] then j := j+1;
		if A[j] <= RootKey then
			NotFinished := FALSE
		else begin
			A[i] := A[j];
			i := j;
			j := 2*i;
			NotFinished := (j<=n)
			end
		end;
	A[i] := RootKey
end;

(* HeapSort(A,n)
   preconditions: A is an array of size n storing values of type KeyType
   postconditions: A has been sorted using the HeapSort algorithm found in program 13.10 *)

procedure HeapSort(var A: SortingArray; n: integer);
var
	i: integer;
	Temp: KeyType;
begin
	for i := (n div 2) downto 2 do SiftUp(A,i,n);
	for i := n downto 2 do begin
		SiftUp(A,1,i);
		Temp := A[1]; A[1] := A[i]; A[i] := Temp
		end
end;

(************************************ QUICK SORT ***********************************)

(* Partition(A,i,j)
   preconditions: A is an array, and [i..j] is a range of values to be partitioned
   postconditions: A[i..j] has been partitioned using the Partition algorithm found in program 13.15 *)

procedure Partition(var A: SortingArray; var i,j: integer);
var Pivot, Temp: KeyType;
begin
	Pivot := A[(i+j) div 2];
	repeat
		while A[i]<Pivot do i := i+1;
		while A[j]>Pivot do j := j-1;
		if i<=j then begin
			Temp := A[i]; A[i] := A[j]; A[j] := Temp;
			i := i+1;
			j := j-1
			end;
	until i>j
end;

(* QuickSort(A,m,n)
   preconditions: A is an array, and [m..n] is a range of values to be sorted
   postconditions: A[m..n] has been sorted using the QuickSort algorithm found in program 13.14 *)

procedure QuickSort(var A: SortingArray; m,n: integer);
var i,j: integer;
begin
   if m<n then begin
      i := m; j := n;
      Partition(A,i,j);
      QuickSort(A,m,j);
      QuickSort(A,i,n)
   end
end;

(************************************ RADIX SORT ***********************************)

(* Power(x,n)
	preconditions: x and n are integers
	postconditions: returns x^n 
HINT: you may need this when you are isolating the digits in RadixSort *)

function power(x,n: integer): integer;
var i, result: integer;
begin
   result := 1;
   for i := 1 to n do
      result := result * x;
   power := result
end;

(* RadixSort(A,n)
   preconditions: A is an array of size n
   postconditions: A[1..n] has been sorted using the RadixSort algorithm *)

procedure RadixSort(var A: SortingArray; n: integer);
var
begin

   { YOUR CODE GOES HERE }

end;

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

procedure MakeRandomArray(var A: SortingArray; n: integer);
var i: integer;
begin
   for i := 1 to n do begin
      A[i] := trunc( MAXINT * Random(i) ) ;
      A[i] := Abs(A[i])
      end
end;

(* PrintArray(A,n)
   preconditions: A is an array of size n
   postconditions: A[1..n] is printed to the screen *)

procedure PrintArray(var A: SortingArray; n: integer);
var i: integer;
begin
   writeln;
   for i := 1 to n do
      write(A[i],' ');
   writeln
end;

(* IsSorted(A,n)
   preconditions: A is an array of size n
   postconditions: Returns TRUE if A[1..n] is sorted in ascending order.  Returns FALSE otherwise *)

function IsSorted(var A: SortingArray; n: integer): boolean;
var i: integer;
begin
	IsSorted := TRUE;
	for i := 2 to n do
		if A[i]<A[i-1] then IsSorted := FALSE
end;

(************************************ EXTRA STUFF ***********************************)

var
	A: SortingArray; {Array to sort}
	n,               {Number of elements in array}
	choice,          {User input}
	i,               {counter}
	t,               {Number of trials}
	correct: integer;   {Number of correct runs}

begin
{   randomize;  {initialize the random number seed}
   repeat
      writeln;
      writeln('1. HeapSort an Array,');
      writeln('2. QuickSort an Array,');
      writeln('3. RadixSort an Array,');
      writeln('4. Test HeapSort,');
      writeln('5. Test QuickSort,');
      writeln('6. Test RadixSort,');
      writeln('7. quit');
      writeln; readln(choice);

      case choice of
         1,2,3: begin
            Writeln('This option creates a random array and sorts it');
            Writeln;
            Write('How many elements in the array?'); readln(n);
            MakeRandomArray(A,n);
            Writeln; Writeln('The random array: ');
            if n <= 300 then
               PrintArray(A,n)
            else
               Writeln('*** too BIG to print ***');
            Writeln;
            Write('Press Enter to sort');
            readln;
            case choice of
               1: HeapSort(A,n) ;
               2: QuickSort(A,1,n) ;
               3: RadixSort(A,n) ;
            end;
            writeln; Writeln('The sorted array: ');
            if n <= 300 then
               PrintArray(A,n)
            else
               Writeln('*** too BIG to print ***');
            Writeln;
		Write('"IsSorted" returned ',  IsSorted(A,n) ) ;
            readln;
         end;

         4,5,6: begin
            Writeln('This option tests a sorting algorithm on a bunch of arrays.');
            Writeln;
            Write('How many elements in each array?'); readln(n);
            Write('How many tests do you want to do?'); readln(t);
            correct := 0;
            for i := 1 to t do begin
               MakeRandomArray(A,n);
               case choice of
                  4: HeapSort(A,n) ;
                  5: QuickSort(A,1,n) ;
                  6: RadixSort(A,n) ;
               end;
               if IsSorted(A,n) then correct := correct + 1;
            end;
            writeln;
            writeln('IsSorted returned TRUE ', correct, ' times in ', t, ' trials.');
            readln;
         end;

      end;

   until (choice = 7);
end.