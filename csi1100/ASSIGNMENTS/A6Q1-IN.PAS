{ Mark Sattolo  428500 }
{ CSI-1100A  DGD-1  TA: Chris Lankester }
{ Assignment 6, Question 1 }

program  INSERT (input, output);

{ Take a non-decreasing sorted array X with N numbers, and a number Num, and
  find the first position in X where Num can be inserted in the proper order. }

{ Data Dictionary
   Givens:   Num - a number to be inserted into list X.
   Results:  none
   Modifieds:	X - sorted list of N numbers in non-decreasing order.  List X will be
   				modified to have Num added in the correct place.
   			N - number of values in list X.  This will be modified to have value
   				N+1 for the modified X.
   Intermediates: J - the minimum index value where Num could be inserted in list X.
   Uses:  (J) <-- SEARCH(X,N,Num)
   		MAKEROOM(X,N,J)
   		FillArray(X,N)		 }

type
    Markarray = array[1..27] of integer;

var
   N, Num, J : integer;
   X : Markarray;

{*************************************************************************}
	procedure SWAP(var X, Y : integer);
	
	var
		Temp : integer;
		
	begin
		Temp := X;
		X := Y;
		Y := Temp
	end;
	
{*************************************************************************}
   procedure SEARCH(N, Num : integer;  X : Markarray; var J : integer);

   var
      JNotFound : boolean;

   begin  { Search }
        J := 0;
        JNotFound := true;
        while ((J < N) and JNotFound) do
        		begin
             		J := J + 1;
               	if (NUM <= X[J]) then
                    	JNotFound := false
               	else { do nothing }
             	end; { while }
        if JNotFound then
     		J := N + 1
   end; { procedure SEARCH }

{***********************************************************************************}
   procedure MAKEROOM(J : integer; var X: Markarray; var N : integer);

   var
      Pos, Temp : integer;

   begin	{ MAKEROOM }
   	   X[N+1] := 0;
        Pos := J;
        Temp := 0;
        while Pos <= N+1 do
        		begin
              		SWAP(X[Pos], Temp);
              		Pos := Pos + 1
			end; { while }
        N := N + 1
   end; { procedure MAKEROOM }

{*************************************************************************************}
  procedure FillArray(var ArrayName : MarkArray; var ArraySize : integer);
  
  var
	K : integer;	{ K - an index in the prompt for values. }
    
  begin	{ procedure FillArray }
  	write('Please enter the size of the array?  ');
     readln(ArraySize);
     for K := 1 to ArraySize do
         begin
              write('Please enter array value #', K, '?  ');
              read(ArrayName[K])
         end { for }
  end; 	{ procedure FillArray }
  
{*************************************************************************************}
  
begin  { program }

	{ Get the input values }
	writeln('For X:');
	FillArray(X, N);
	writeln;
	write('Please enter the value for Num: ');
	Readln(Num);
	
	{ body }
	
	SEARCH(N, Num, X, J);
	MAKEROOM(J, X, N);
	X[J] := Num;
	
     { Print out the results. }
     writeln;
     writeln('*************************************');
     writeln('Mark Sattolo  428500');
     writeln('CSI-1100A  DGD-1  TA: Chris Lankester');
     writeln('Assignment 6, Question 1');
     writeln('*************************************');
     writeln;
     writeln('The modified elements in X are: ');
     for J := 1 to N do
     	write(X[J]:6);
     writeln;

end. 
