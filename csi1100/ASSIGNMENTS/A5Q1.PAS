{ Mark Sattolo,  428500,  CSI-1100A,  prof: Dr. S. Boyd }
{ Tutorial #1,  TA: Chris Lankester }
{ Assignment 5, Question 1(b) }

program GetRoots (input,output);

{ Prompt for three integers A, B and C, then calculate and display the real roots, if any, }
{ of the quadratic equation Ax^2 + Bx + C = 0; or inform the user that there are no real roots. }

{ Data Dictionary
   GIVENS: A, B, C  - three integers.
   RESULTS: FirstRoot, SecondRoot - the real roots of the equation Ax^2 + Bx + C = 0.
            NoRoots - a boolean which is true if there are no real roots of the equation,
                      and false otherwise.
   INTERMEDIATES:  none
   USES:  SQR, SQRT - functions which calculate square and square root, respectively.  }

var
	A, B, C : integer;
	BP2, DISC, RTDISC, FirstRoot, SecondRoot : real;
	NoRoots : boolean;

begin

	{ Read in the algorithm's givens. }

	writeln('Please enter the values for A, B and C.');
	readln(A, B, C);

    { set initial values for results and intermediates }

    NoRoots := false;
    BP2 := SQR(B);
    DISC := BP2 - (4 * A * C);
    
    { begin the calculations for the different cases }

    if A = 0 then
       begin
 		if B > 0 then
              begin
              		FirstRoot := (-C / B);
              		SecondRoot := FirstRoot
              end  { if B > 0 }
           else
               NoRoots := true;
       end  { if A = 0 }
    else if DISC < 0 then
		begin
			NoRoots := true;
			FirstRoot := 0;
			SecondRoot := 0
		end  { if DISC < 0 }
	     else
	     	begin
	     		RTDISC := SQRT(DISC);
				FirstRoot := (-B + RTDISC)/(2*A);
	     		SecondRoot := (-B - RTDISC)/(2*A);
	     	end;  { else DISC < 0 }

{ Write out the results }

	writeln;
	writeln('*******************************************************');
	writeln('Mark Sattolo,  428500,  CSI-1100A');
	writeln(' prof: Dr. S. Boyd,  Tutorial #1,  TA: Chris Lankester');
	writeln('Assignment 5, Question 1(b)');
	writeln('*******************************************************');
	writeln;
    writeln;

    if B < 0 then
    	if C < 0 then
			writeln('The polynomial is: ', A, 'x^2 - ', Abs(B), 'x - ', Abs(C), ' = 0')
		else
			writeln('The polynomial is: ', A, 'x^2 - ', Abs(B), 'x + ', C, ' = 0')
    else if C < 0 then
			writeln('The polynomial is: ', A, 'x^2 + ', B, 'x - ', Abs(C), ' = 0')
	     else
			writeln('The polynomial is: ', A, 'x^2 + ', B, 'x + ', C, ' = 0');

    if NoRoots then
			writeln('Sorry, there are no real roots.')
        else
	      if FirstRoot = SecondRoot then
	    	writeln('The root is: x = ', FirstRoot:2:1)
	      else
	        writeln('The roots are: x = ', FirstRoot:2:1, ' and x = ', SecondRoot:2:1)
end.