program Power (Input, Output);

{Program to compute power using recursion}

var
     Number : Integer;

{**********************************************************************}
    function Power (X : real; N : Integer) : Real;

    { Function computes X^N using recursive calls to itself }

	var
		temp : real;
		
    begin  {Power}
     	if N = 0 then
             Power := 1
        else if (N div 2) = 0 then
        	begin
        		temp := Power(X, N-1);
        		Power := temp * temp;
        	end	{ if N div 2 = 0 }
        	else
        		begin
        			temp := Power(X, N-1);
        			Power := temp * N;
        		end;	{ else }
     end;   { Function Power }
{**********************************************************************}
begin  {Main Program}

{1.0 Read Number}

     Write ('Enter X: ');
     Readln (X);
     Write ('Enter N: ');
     Readln (N);
	
	writeln('The value of X^N is ', Power(X, N):9);
	
end.   {Main Program}
