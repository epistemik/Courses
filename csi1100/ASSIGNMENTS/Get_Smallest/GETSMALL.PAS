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
   USES:  FindSmallX, Compare }

type
    Markarray = array[1..66] of integer;

var
   N, M, Smallest, Count, SmallX : integer;
   X : Markarray;
   Y : Markarray;

{*******************************************************************}

 procedure TestX(X : Markarray; N, Previous : integer; var SmallX, I : integer);

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
        TestX(X, N, Previous, SmallX, I);
        while (I < (N-1)) do
             begin
             I := I + 1;
               if ((X[I+1] < SmallX) and (X[I+1] > Previous)) then
                    SmallX := X[I+1]
               else { do nothing }
             end { while }
   end; { procedure FindSmallX }

{***********************************************************************************}

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

  procedure FillArray(var ArrayName : MarkArray; var ArraySize : integer);
  
  var
	K : integer;	{ K - an index in the prompt for values. }
    
  begin
  	write('Please enter the size of the array?  ');
     readln(ArraySize);
     for K := 1 to ArraySize do
         begin
              write('Please enter array value #', K, '?  ');
              read(ArrayName[K])
         end { for }
  end;  { procedure FillArray }
  
{*************************************************************************************}
  
begin  { program }

	{ Get the input values }
	writeln('For the first array:');
	FillArray(X, N);
	writeln;
	writeln('For the second array:');
	FillArray(Y, M);
	
     { initialize the loop }
     Count := 0;
     Smallest := -1;
     SmallX := 0;

     { start the loop}
     while ((Count < N) and (Smallest < 0)) do
           begin
                FindSmallX(N, X, SmallX);
                Compare(Y, M, SmallX, Smallest);
                Count := Count + 1
           end; { while }

     { Print out the results. }
     writeln;
     writeln('*************************************');
     writeln('Mark Sattolo   428500');
     writeln('CSI1100A   DGD-1   Chris Lankester');
     writeln('Assignment 4, Question 2');
     writeln('*************************************');
     writeln;
     writeln('The value of Smallest is ',Smallest,'.');

end. { program }
