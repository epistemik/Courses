{ Mark Sattolo   428500 }
{ CSI1100A   DGD-1   Chris Lankester }
{ Test program for Assignment#4 Question#2 }

program  GetSmallest (input, output);

{ This program takes an array X with N positive numbers, and a second array Y with M positive
  numbers, and gives the smallest number that appears in both arrays as the result "Smallest",
  or sets Smallest to -1 if there is no common element in the two arrays. }

{ Data Dictionary
   GIVENS:   X, N - X is an array of N positive integers.
             Y, M - Y is an array of M positive integers.
   RESULTS:  Smallest - the smallest value in both arrays, or -1 if there is no common element.
   INTERMEDIATES: Count - a counter to keep track of the # of passes through the top module.
                  SmallX - the current smallest value of X.
   USES:  FindSmallX, Compare, Swap }

type
    Markarray = array[1..66] of integer;

var
   N, M, Smallest, Count, SmallX, Size, k, l, i, j, g, h : integer;
   X, Y : Markarray;

{***********************************************************************}
	procedure Swap(var X, Y : integer);
	var
		Temp : integer;
	begin
		Temp := X;
		X := Y;
		Y := Temp
	end;	{ procedure Swap }
	
{***********************************************************************}

 procedure CheckX(X : Markarray; N, Previous : integer; var SmallX, I : integer);

 begin
      while ((I < (N-1)) and (SmallX <= Previous)) do
            begin
                 I := I + 1;
                 SmallX := X[I+1]
            end { while }
 end; { procedure TestX }

{*************************************************************************}

   procedure FindSmallX(N : integer;  X : Markarray; var SmallX : integer);

   var
      I, Previous : integer;

   begin  { FindSmallX }
        I := 0;
        Previous := SmallX;
        SmallX := X[1];
        CheckX(X, N, Previous, SmallX, I);
        while (I < (N-1)) do
             begin
             I := I + 1;
               if ((X[I+1] < SmallX) and (X[I+1] > Previous)) then
                    SmallX := X[I+1]
               else { do nothing }
             end { while }
   end; { procedure FindSmallX }

{*************************************************************************}

   procedure Compare(Y: Markarray; M, SmallX : integer; var Smallest : integer);

   var
      J : integer;

   begin
        J := 0;
        while ((J < M) and (Smallest < 0)) do
              begin
              J := J + 1;
                if (Y[J] = SmallX) then
                Smallest := SmallX
                else { do nothing}
              end { while }
   end; { procedure Compare }

{*************************************************************************************}
  
begin  { program }

	{ Get the array size }
	writeln('Enter the size of the arrays: ');
	readln(Size);
	N := Size;
	M := Size;
	
	{ Use two loops to fill the arrays }
	For k := 1 to Size do
		For l := 1 to Size do
		begin
			For i := 1 to N do
				X[i] := i;
			Swap(X[1], X[k]);
			For j := 1 to M do
				Y[j] := j;
			Swap(Y[1], Y[l]);
		
		     { initialize the test loop }
		     Count := 0;
		     Smallest := -1;
		     SmallX := 0;
		
		     { start the test loop}
		     while ((Count < N) and (Smallest < 0)) do
		           begin
		                FindSmallX(N, X, SmallX);
		                Compare(Y, M, SmallX, Smallest);
		                Count := Count + 1
		           end; { while }
		
		     { Print out the results. }
		     writeln;
		     writeln('еееееееееееееееееееееееееееееееееееее');
		     writeln('Mark Sattolo   428500');
		     writeln('CSI1100A   DGD-1   Chris Lankester');
		     writeln('Test of auto data entry for A4-Q2');
		     writeln('еееееееееееееееееееееееееееееееееееее');
		     writeln;
		     write('The values of X are: ');
		     for g := 1 to N do
		         write(X[g]:3);
		     writeln;
		     writeln;
		     write('The values of Y are: ');
		     for h := 1 to M do
		         write(Y[h]:3);
		     writeln;
		     writeln;
		     writeln('The value of Smallest is ',Smallest,'.')
		end	{ for l }
end. 