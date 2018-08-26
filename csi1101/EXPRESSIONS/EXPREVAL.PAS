{ CSI 1101-X,  Winter 1999 }
{ Mark Sattolo,  student# 428500 }

program ExpressionEvaluate ;

uses EqnTPU ;

procedure Precedence(var Subeqn: stack; var Answer: element) ;
var
	nums, ops : stack ;
	L, R, OP, X : element ;
BEGIN
	create_stack(nums) ;
	create_stack(ops) ;

	while (Subeqn.size > 0) do
		BEGIN
		pull(X, Subeqn) ;
		if ((length(X) = 1) & ((X < '0') | (X > '9'))) then
			BEGIN

{TESTING}	writeln('X is an operator.');
			while ((Ops.size > 0) & (Priority(top(ops)) >= Priority(X))) do
        			BEGIN
				pull(R, nums) ;
				pull(L, nums) ;
				pull(OP, ops) ;
				push(Eval(L, R, OP[1]), nums) ;
				write('Eval-1 output is: '); write_stack(nums) ;  { TESTING }
				END;  { while }

{TESTING}	writeln('pushing X onto Ops.') ;
			push (X, ops)
			END  { if }
		else 
			push (X, nums) ;

            END;  { while }

	while (Ops.size > 0) do
		BEGIN
		pull(R, nums) ;
		pull(L, nums) ;
		pull(OP, ops) ;
		push(Eval(L, R, OP[1]), nums);
		write('Eval-2 output is: '); write_stack(nums) ;  { TESTING }
         	END;  { while }

      Answer := top(nums) ;
      destroy(nums) ;
      destroy(ops) ;
END;  { proc Precedence }


procedure Brackets(var Eqn, Answer: element) ;
var
	S, T: stack ;
	X, Mid : element ;
BEGIN
	create_stack(S) ;
	create_stack(T) ;
	Mid := '' ;

	while (length(Eqn) > 0) do
		BEGIN
		get_X(Eqn, X) ;
		if ( X <> ')' ) then
			push (X, S)
		else
			BEGIN

			while ( top(S) <> '(' ) do
				BEGIN
				push (top(S), T) ;
				pop (S)
				END;  { while }

			pop (S) ;
			Precedence (T, Mid) ;
			push (Mid, S)
			END  { else }
		END;  { while }

	while (S.size > 0) do
		BEGIN
		push(top(S), T) ;
		pop(S)
		END;  { while }

	Precedence (T, Answer) ;
	destroy(S) ;
	destroy(T)
END;  { proc Brackets }


procedure Equation;
var
	eqn, Answer: element ;
BEGIN
	writeln('Enter a numeric expression to be evaluated: ');
	writeln(' [ div = /, mult = *, power = ^, brackets = () ] ') ;
	readln(eqn) ;
	brackets(eqn, Answer) ;
	writeln('This equation evaluates to: ', Answer) 
END;  { proc Equation }


BEGIN  { main program }

	identify_myself ;
	repeat
		mem_count := 0 ;
		Equation ;
		if ( mem_count <> 0 ) then
			writeln('Memory Leak!  Dynamic memory allocated but not returned: ',
					 mem_count:0) ;
   		writeln('Do you wish to continue (y or n) ?') ;
   		readln(continue) ;
   	until
   		continue in ['n', 'N'] ;
   	writeln('PROGRAM ENDED.') 
END.
