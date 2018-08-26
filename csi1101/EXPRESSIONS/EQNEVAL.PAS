{ CSI 1101-X,  Winter 1999,  A6q1 }
{ Mark Sattolo,  student# 428500 }

{* The Bracket Matching Algorithm used in this program
   ---------------------------------------------------------
This follows very closely what was described in class.  It is implemented in three
procedures; the names are not the ones used in class but their functions are the same:

	Brackets,  Process_right_bracket,  Convert_left_to_right,  Convert_to_postfix.

Procedure  BRACKETS:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Repeat the following until end-of-line:
	1. Read the next character.
	2. If it is NOT a right bracket, push it on the stack S.
	3. If it is a right bracket, do the following

     (a)  procedure  PROCESS_RIGHT_BRACKET:
     Pop characters off of stack S and push them onto a temporary stack 
until you reach a left bracket (this is the bracket that matches with the 
right bracket you just read).  Pop that bracket off of S.
     The temporary stack now contains all the characters that were in-between
the two brackets, and they are in the same order that they were initially read
(the first one read is on the top of the temporary stack).

     (b)  procedure  CONVERT_LEFT_TO_RIGHT:
     "Process" the characters between the two brackets (i.e. the ones that
are on the temporary stack).  In general you can do any sort of processing you
like.  For example, you could evaluate this expression. In the current program,
the infix expression is converted to postfix (this is done by successive calls
to "Convert_to_postfix").

     (c)  The processing in step (b), whatever it is, is assumed to return an
"answer".  In this case the answer returned is a string containing a postfix
expression.  PUSH this answer onto stack S.

     (d)  When end-of-line is encountered, you need to do exactly the same 
processing as in step 3, EXCEPT:  there is no left bracket on stack S to 
"match" with end-of-line, so the loop in 3(a) will not terminate.  I could 
have written a separate procedure to handle end-of-line, but instead I used
a "trick" which allows me to use the procedure "Process_right_bracket" when 
I encounter end-of-line.  The "trick" is to treat beginning-of-line as a left
bracket and end-of-line as its matching right bracket.  The way this is 
implemented is simply to push a left bracket onto stack S just before reading
begins.  When end-of-line is encountered, "Process_right_bracket" is called
and the left bracket representing beginning-of-line is sitting at the bottom 
of stack S.	*}

program EqnEval (input,output) ;

uses EqnTPU ;

{ CONVERT_LEFT_TO_RIGHT
  - the given stack, "tokens", contains an infix expression with no brackets, just 
  operators and operands, with top-to-bottom in "tokens" corresponding to left-to-right
  in the order the user entered the infix expression.  The result ("result") is a postfix 
  expression corresponding to the infix one given in "tokens".  "tokens" itself becomes
  empty.  This procedure does no error checking, so if an incorrect expression is entered
  between brackets it will crash.  You are not required to fix this - but be careful not to
  enter expressions such as (1+). } 
procedure convert_left_to_right(var tokens: stack; var result: element);
var
	L, OP, R: element;
BEGIN
	L := top(tokens);
	pop(tokens);
	while (tokens.size > 0) do
		BEGIN
		pull(OP, tokens) ;
		pull(R, tokens) ;
		L := Eval(L, R, OP[1])
		END; { while }
	result := L
END; { proc convert_ltr }


{ PROCESS_RIGHT_BRACKET
  - pops items off of stack S and onto a temporary stack, BetweenBrackets, until a
  left bracket is encountered, at which time BetweenBrackets is passed to 
  convert_left_to_right. The postfix expression returned by this is pushed onto S. }
procedure process_right_bracket(var S:stack; var error:boolean);
var
   	BetweenBrackets: stack ;
	V: element ;
	done: boolean ;
BEGIN
	create_stack(BetweenBrackets) ;
	done := false ;

	while (not done) do
{*}		BEGIN
		{ detect missing left bracket }
		if (S.size <= 0) then
			BEGIN				
			if not error then   { if multiple omissions }
				writeln('Error: Missing left bracket(s). Processing was terminated because') ;
			error := true ;
	            { destroy any existing nodes if an error was found }
			destroy(BetweenBrackets) ;	{ needed before 'exit' because this exits the }
			exit ;							{ entire procedure }
			END { if }
{$}		else
			BEGIN
			pull(V, S) ;
			if V = '(' then
				done := true
			else
				push(V, BetweenBrackets) ;
			END  { else }
		END; { while }
	
	{ detect mismatched brackets and prevent an error for the "nil" expression }	
{*}	if (BetweenBrackets.size > 0) then
		BEGIN
  		convert_left_to_right(BetweenBrackets,V);
  		push(V, S)
{*}		END; { else }
END; { proc process_rb }


{ BRACKETS 
  - reads in one character at a time from the input line; if the character is not a ')' it 
  pushes it onto a stack ("S"), if it is a ')' then process_right_bracket is called with 
  stack "S".  When end-of-line is reached process_right_bracket is called one more time
  - in order to make this call work correctly it is necessary to initially push onto "S" 
  a '(' that corresponds to the imaginary ')' that end-of-line represents.  }
procedure Brackets (var V: element; var error:boolean) ;
var
	S: stack ;
	E, X: element ;
BEGIN
	V := '' ;			{ initialize V to prevent erroneous output for "nil" expression }
	error := false ;	{ set initial error to false }
	create_stack(S);
	push('(', S) ;    	{* trick to allow us to use same code for ')' and end-of-line *}
	readln(E) ;
	while (length(E) > 0) do
		BEGIN
		get_X(E, X) ;
		if X=')' then
			process_right_bracket(S, error)
		else
			push(X, S) ;
		END;  { while }
		
	process_right_bracket(S, error) ;

	{ do not process if S is empty }
{*}	if (S.size > 0) then
{$}		BEGIN
		pull(V, S) ;
		{ detect missing right bracket }
{*}		if (S.size > 0) then
			BEGIN				
			writeln('Error: Missing right bracket(s). Processing was terminated because') ;
			error := true ;
			END  { if #2 }
		END; { if #1 }
		
	{ destroy the existing nodes if an error was declared }
	if error then
{$}		destroy(S) ;
END;  { proc Brackets }


procedure go ;
var
	answer: element;
	error: boolean ;
BEGIN
	writeln;
	writeln('Please enter a numeric expression: ');
	writeln(' <[ div = /, mult = *, power = ^, brackets = () ]> ') ;
	Brackets(answer, error);
	if error then
		writeln('your expression contained mismatched brackets.')
	else
		BEGIN
		write('Your expression evaluates to: ');
		writeln(answer)
	     	END  { else }
END;  { proc go }


BEGIN  { main program }

	identify_myself ;
	repeat
		mem_count := 0 ;
		go ;
		if ( mem_count <> 0 ) then
			writeln('Memory Leak!  Dynamic memory allocated but not returned: ',
					 mem_count:0) ;
		writeln('Do you wish to continue (y or n) ?') ;
		readln(continue)
	until
		continue in [ 'n', 'N' ] ; 
	   	writeln('PROGRAM ENDED.') 
END.