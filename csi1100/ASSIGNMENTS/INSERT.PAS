{ Mark Sattolo   428500 }
{ CSI-1100A   DGD-1   Chris Lankester }
{ Test program for Assignment#3 Question#2 }

program  Insert (input, output);

{ This program takes a non-decreasing sorted array X with N numbers, and a number NUM,
  and finds the first position in X where NUM can be inserted in the proper order. }

{ Data Dictionary
   GIVENS:   NUM - a number to insert in X in the proper sorted position.
   RESULTS:  none
   Modifieds:	X, N - X is a non-decreasing list of N numbers.
   INTERMEDIATES: J - the index position in X to insert NUM.
   USES:  Search, MakeRoom }

type
    Markarray = array[1..66] of integer;

var
   N, NUM, J : integer;
   X : Markarray;

{*************************************************************************}
	procedure Swap(var X, Y : integer);
	
	var
		Temp : integer;
		
	begin
		Temp := X;
		X := Y;
		Y := Temp
	end;
	
{*************************************************************************}
   procedure Search(N, NUM : integer;  X : Markarray; var J : integer);

   var
      Jfound : boolean;

   begin  { Search }
        J := 0;
        Jfound := false;
        while ((J < N) and (NOT Jfound)) do
        		begin
             		J := J + 1;
               	if (NUM <= X[J]) then
                    	Jfound := true
               	else { do nothing }
             	end; { while }
        if NOT Jfound then
     		J := N + 1
   end; { procedure FindSmallX }

{***********************************************************************************}
   procedure MakeRoom(J : integer; var X: Markarray; var N : integer);

   var
      I : integer;
      Jroom : boolean;

   begin
        Jroom := false;
        N := N + 1;
        X[N] := 0;
        I := N;
        while NOT Jroom do
        		begin
            		I := I - 1;
                	if (I < J) then
                		Jroom := true
                	else 
                		Swap(X[I], X[I+1])
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
	writeln('For X:');
	FillArray(X, N);
	writeln;
	writeln('Please enter the value for NUM:');
	Readln(NUM);
	
	{ body }
	
	Search(N, NUM, X, J);
	MakeRoom(J, X, N);
	X[J] := NUM;
	
     { Print out the results. }
     writeln;
     writeln('*************************************');
     writeln('Mark Sattolo   428500');
     writeln('CSI-1100A   DGD-1   Chris Lankester');
     writeln('Assignment 3, Question 2');
     writeln('*************************************');
     writeln;
     writeln('The new value of X is: ');
     for J := 1 to N do
     	write(X[J], ' ');
     

end. { program }
