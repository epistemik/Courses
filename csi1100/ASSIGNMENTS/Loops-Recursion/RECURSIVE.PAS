program RecursiveFxns (Input, Output);

{ Program to compute using recursive functions }

var
     X : real;
     N : integer;
   
{**********************************************************************}
    function Power (X : real; N : integer) : Real;

    { Compute X^N using recursive calls }

	var
		temp : real;
		
    begin  { function Power }
     	if N = 0 then
             	Power := 1
        else if (N mod 2) = 0 then
        	begin
        		temp := Power(X, N div 2);
        		Power := temp * temp;
        	end	{ if N mod 2 = 0 }
        	else
        		begin
        			temp := Power(X, ((N-1) div 2));
       				Power := temp * temp * X;
        		end;	{ else }
     end;   { Function Power }

{**********************************************************************}
	function Root(A : real; I : integer) : real;
	
	{ Compute square root using a recursive approximation formula }
	
	begin	{ function Root }
		if I = 1 then
			Root := A/2
		else
			Root := (Root(A, I-1) + A/Root(A, I-1))/2;
	end;	{ function Root }

{ ************************************************************************ }
	
begin  { Main Program }

	{ input }

     writeln('To test the recursive Power and Root functions for X^N,');
     Write('Please enter X: ');
     Readln (X);
     Write('Please enter N: ');
     Readln (N);
	
	{ computations and output }
	
	writeln('"Power" gives the value of X^N as ', Power(X, N):9:3);
	writeln;
	writeln('ROOT gives the square root of ', X:7:3, ' after ', N, ' loops as', root(X, N):9:5);
	writeln('SQRT(', X:7:3, ') gives ', SQRT(X):9:5);
	writeln('SQR(ROOT(', X:7:3, ',', N, ')) gives ', SQR(root(X, N)):7:3);	
end.  
