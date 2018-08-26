program a6q1delphi;

uses
    A6Q1TPU in 'A6Q1TPU.pas',
    Unit1 in 'Unit1.pas'; {Needed for Delphi}

{$R *.RES}

{* CSI 1101-X,  Winter, 1999  *}
{* Assignment 6, Question #1 *}
{* Identification: Mark Sattolo, student# 428500  *}
{* tutorial group DGD-4, t.a. = Jensen Boire    *}

{
The Bracket Matching Algorithm used in this program
---------------------------------------------------
(this follows very closely what was described in class.
It is implemented in three procedures (the names are not the ones used
in class but there functions are the same) -

  brackets,  process_right_bracket,  convert_left_to_right,  convert_to_postfix.

procedure "brackets:

Repeat the following until end-of-line:
1. Read the next character.
2. If it is NOT a right bracket, push it on the stack S.
3. If it is a right bracket, do the following

     (a) (procedure "process_right_bracket"):

     Pop characters off of stack S and push them onto a temporary stack
until you reach a left bracket (this is the bracket that matches with the
right bracket you just read).  Pop that bracket off of S.
     The temporary stack now contains all the characters that were in-between
the two brackets, and they are in the same order that they were initially read
(the first one read is on the top of the temporary stack).

     (b) (procedure "convert_left_to_right")

     "Process" the characters between the two brackets (i.e. the ones that
are on the temporary stack).  In general you can do any sort of processing you
like.  For example, you could evaluate this expression. In the current program,
the infix expression is converted to postfix (this is done by successive calls
to "convert_to_postfix").

     (c) The processing in step (b), whatever it is, is assumed to return an
"answer".  In this case the answer returned is a string containing a postfix
expression.  PUSH this answer onto stack S.

     When end-of-line is encountered, you need to do exactly the same
processing as in step 3, EXCEPT:  there is no left bracket on stack S to
"match" with end-of-line, so the loop in 3(a) will not terminate.  I could
have written a separate procedure to handle end-of-line, but instead I used
a "trick" which allows me to use the procedure "process_right_bracket" when
I encounter end-of-line.  The "trick" is to treat beginning-of-line as a left
bracket and end-of-line as its matching right bracket.  The way this is
implemented is simply to push a left bracket onto stack S just before reading
begins.  When end-of-line is encountered, process_right_bracket" is called
and the left bracket representing beginning-of-line is sitting at the bottom
of stack S. }

var
   YESorNO: char ;

{***************** EXPRESSION PROCESSING *********************}

{ convert_to_postfix - constructs a postfix expression from the given operator, OP,
  and its left and right operands, L and R.  The result is returned in L. }
procedure convert_to_postfix(var L,OP,R: string);
BEGIN
     L := concat(L,' ',R,' ',OP)
END ;

{ convert_left_to_right - the given stack, "tokens", contains an infix
  expression with no brackets, just operators and operands, with top-to-bottom
  in "tokens" corresponding to left-to-right in the order the user entered
  the infix expression.  The result ("result") is a postfix expression
  corresponding to the infix one given in "tokens".  "tokens" itself becomes
  empty.  This procedure does no error checking, so if an incorrect expression
  is entered between brackets it will crash.  You are not required to fix this
  - but be careful not to enter expressions such as (1+). }
procedure convert_left_to_right(var tokens:stack; var result: string);
var
   L,OP,R: string;
BEGIN
     top(tokens,L);
     pop(tokens);
     while not is_empty(tokens) do
       BEGIN
       top(tokens,OP);
       pop(tokens);
       top(tokens,R);
       pop(tokens);
       convert_to_postfix (L,OP,R)
       END; { while }
     result := L
END; { proc convert_ltr}

{ process_right_bracket - pops items off of stack S and onto a temporary
  stack, BetweenBrackets, until a left bracket is encountered, at which time
  BetweenBrackets is passed to convert_left_to_right. The postfix expression
  returned by convert_left_to_right is pushed onto S. }
procedure process_right_bracket( var S:stack; var error:boolean);
var
   BetweenBrackets: stack;
   v: stackitem ;
   done: boolean;
BEGIN
     create(BetweenBrackets);
     done := false ;
     error := false ;	{ addition }
     while (not done) do
{*}    BEGIN
       if is_empty(s) then
	 BEGIN 	{ missing left bracket }
	 writeln('Error: Missing left bracket.  Processing was terminated because') ;
	 error := true ;
	 destroy(BetweenBrackets) ;	{ needed because 'exit' exits the }
	 exit ;				{ entire procedure }
	 END { if }
       else
	   BEGIN
	   top(s,v) ;
	   pop(s) ;
	   if v = '(' then
	     done := true
	   else
	       push(v,BetweenBrackets) ;
	   END  { else }
       END; { while }
{*}  if is_empty(BetweenBrackets) then
       BEGIN
       writeln('Error #2') ; { mismatched empty L or R bracket }
       error := true
       END
     else
	 BEGIN
  	 convert_left_to_right(BetweenBrackets,v);
  	 push(v,s)
{*}	 END; { else }
    {if error then
{      destroy(BetweenBrackets) ;}
END;
{ procedure process_right_bracket() }


{ brackets - reads in one character at a time from the input line; if the
  character is not a ')' it pushes it onto a stack ("S"), if it is a ')' then
  process_right_bracket is called with stack "S".  When end-of-line is reached
  process_right_bracket is called one more time - in order to make this call
  work correctly it is necessary to initially push onto "S" a '(' that
  corresponds to the imaginary ')' that end-of-line represents.  }
procedure brackets (var v: stackitem; var error:boolean) ;
var
   s: stack;
   c: char;
BEGIN
     create(s);
     push('(',s) ;   {* trick to allow us to use same code for ')' and
                     	end-of-line  [ which we treat as a ')' ]  *}
     while (not eoln) do
       BEGIN
       read(c);
       if c=')' then
	 process_right_bracket(s,error)
       else
           push(''+c,s)
       END; { while }
     readln ;  { clear the end-of-line characters }
     process_right_bracket(s,error) ;
     if not error then
       BEGIN
       top(s,v) ;
       pop(s) ;
{*}    if not is_empty(S) then
	 BEGIN	{ missing right bracket }
	 writeln('Error: Missing right bracket.  Processing was terminated because') ;
	 error := true ;
	 END
       END; { if not error }
     if error then
       destroy(S) ;
END;
{ procedure brackets() }


procedure assignment6q1 ;
var
   answer: string;
   error: boolean ;
BEGIN
     writeln;
     writeln('please enter an infix expression');
     writeln('All numbers (or variable names) must be one digit, and');
     writeln('     the expression must contain no blank spaces.');
     brackets(answer, error);
     if error then
       writeln('your expression contained mismatched brackets')
     else
         BEGIN
         writeln('the postfix equivalent of your expression is:');
         writeln(answer)
         END
END ;
{ procedure assignment6q1 }


{***** YOU MUST CHANGE THIS PROCEDURE TO DESCRIBE YOURSELF *****}

procedure identify_myself ; { Writes who you are to the screen }
BEGIN
     writeln ;
     writeln('CSI 1101-X (winter,1999).  Assignment #6, Question #1.') ;
     writeln('Mark Sattolo, student# 428500.') ;
     writeln('tutorial section DGD-4, t.a. = Jensen Boire');
     writeln
END ;


BEGIN  { main program }

  identify_myself ;

repeat
  memory_count := 0 ;
  assignment6q1 ;
  writeln( 'Amount of dynamic memory allocated but not returned (should be 0) ',
  	   memory_count:0) ;
  writeln( 'Do you wish to continue (y or n) ?' ) ;
  readln(YESorNO);
until (YESorNO <> 'y' )

END.
