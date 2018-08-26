
program Reverse(input, output);
{ Reads in a N-element list of integers and reverses it }

const
   MaxSize = 50;

type
   ArrayType = array[1..MaxSize] of integer;

var
   List : ArrayType;       { array to be reversed }
   N : integer;            { size of array List }
   First, Last : integer;  { array indices }
   i : integer;            { array index }
   ValidSize : boolean;    { boolean to confirm the size of the list is valid }

(**************************** PROCEDURE EXCHANGE ********************************) 

Procedure Exchange (var List: ArrayType; First, Last: integer);

{ Reverses the elements between First and Last in array List }

var
   Temp : integer;         { temporary storage used while switching two values }

begin
   if ((Last - First) <= 0) then	{ Error #1 }
	{ do nothing }
   else
     begin
        Temp := List[Last];			{ Error #2 }
        List[Last] := List[First];
        List[First] := Temp;
        Exchange(List, First + 1, Last - 1);
     end;
end;

(******************************** MAIN PROGRAM **********************************)

begin { Main Program }

   ValidSize := false;
   while (ValidSize = false) do
      begin
         writeln('Enter the size of the list: (at most ', MaxSize,')');	{ Error #5 }
         readln(N);
         if ((N <= MaxSize) and (N >= 0)) then				{ Errors #3, 4 }
            ValidSize := true;
      end;

   writeln('Enter ', N,' integers, a space between each. ');	{ Error #6 }
   for i:= 1 to N do
      read(List[i]);
   First := 1;
   Last := N;
   Exchange(List, First, Last);
   writeln('Reversed list is: ');
   for i := 1 to N do
      write(List[i], ' ');
   writeln;
   writeln;
   writeln('END OF PROGRAM');
end. { Main Program }

