
{ CSI 1101-X,  Winter, 1999  }
{ Identification: Mark Sattolo, student# 428500  }
{ tutorial group DGD-4, t.a. = Jensen Boire }

program ExpressionEvaluate ;

const
	Opers = ['+', '-', '^', '*', '/'] ;

type
	element = string ;
 	pointer = ^node ; 
 	node    = record
              	value: element ;
                next: pointer
  		  	  end ;
	stack = record
 		   	  top: pointer ; 
      		  size: integer ;
			end ;

{ variable for the main program - NOT to be referenced anywhere else }

var YESorNO: char ;

{ The following global variable is used for memory management.  You might
  find it useful while debugging your code, but the solutions you hand in
  must not refer to this variable in any way.}

    memory_count: integer ;


{****** MEMORY MANAGEMENT PROCEDURES *********}

{ get_node - Returns a pointer to a new node. }
procedure get_node( var P: pointer );
begin
  memory_count := memory_count + 1 ;
  new( P )
end ;

{return_node - Make the node pointed at by P "free" (available to get_node).}
procedure return_node(var P: pointer) ;
begin
   memory_count := memory_count - 1 ;
   P^.value  := '-7777.77' ;   { "scrub" memory to aid debugging }
   P^.next   := P ;          { "scrub" memory to aid debugging }
   dispose( P )
end ;

{*********************************************}

{ create_empty - sets stack S to be empty. }
procedure create_empty ( var S: stack ) ;
begin
	S.top := nil ;
	S.size := 0 ;
end;  { proc create_empty }

procedure write_stack ( var S: stack );
var 
   p: pointer ;
begin
	if S.size = 0 then
  		writeln('empty list')
	else
  		begin
    	p := S.top ;
        while p <> nil do
        	begin
            write( ' ', p^.value:7 );
            p := p^.next
            end;  { while }
		writeln
		end;  { else }
end;  { proc write_stack }

procedure destroy( var S: stack) ;
var
	temp : stack ;
begin
	if S.top <> nil then
    	begin
    	temp := S ;
		temp.top := temp.top^.next ;
		destroy(temp) ;
		return_node(S.top) ;
		end;  { if }
end;  { proc destroy}

procedure push(val: string; var S: stack) ;
var
   p: pointer ;
begin
   get_node(p) ;
   p^.value := val ;
   p^.next := S.top ;
   S.top := p ;
   S.size := S.size + 1 ;
end;  { proc push }

procedure pop(var S: stack) ;
var
   p: pointer ;
begin
   if S.size <> 0 then
        begin
        p := S.top ;
        S.top := S.top^.next ;
        return_node(p) ;
        end  { if }
   else
        begin
        writeln('Error: stack is already empty.') ;
        halt ;
        end;  { else }
end;  { proc pop }

function top(S:stack):string ;
begin
	if S.size <= 0 then
		begin
		writeln('Error: Stack is already empty.');
		halt ;
		end  { if }
	else
		top := S.top^.value ;
end;  { fxn top }

procedure pull(var V: string; var S: stack) ;
var
   p: pointer ;
begin
   if S.size <> 0 then
        begin
        V := S.top^.value ;
        p := S.top ;
        S.top := S.top^.next ;
        return_node(p) ;
        end  { if }
   else
        begin
        writeln('Error: stack is already empty.') ;
        halt ;
        end;  { else }
end;  { proc pull }

function Eval(L, R: string; OP: char): string ;
begin
   case OP of

    '+' : Eval := val(L) + val(R) ;

    '-' : Eval := val(L) - val(R) ;

    '^' : Eval := power(val(L), val(R)) ;

    '*' : Eval := val(L) * val(R) ;

    '/' : Eval := val(L) / val(R) 

	else  writeln('Error: improper operator') ;
          halt ;
	end;  { case }
end;  { fxn Eval }

procedure Read(source: string; var X: string) ;
begin
	X := copy(source, 1, 1) ;
	delete(source, 1,1) ;
end;  { proc read }

procedure Precedence(Subeq: string; var Answer: string) ;
var
	Nums, Ops : stack ;
    L, R, OP, X : element ;
begin
	while length(Subeq) > 0 do
		begin
		Read(Subeq, X) ;
		if X in [0..9] then push (X, nums) ;
		if X in Opers then
        	begin
        	while (Ops.size > 0) and (Prec(Top(ops)) >= Prec(X)) do
        		begin
				Pull(R, nums);
				Pull(L, nums);
				Pull(OP, nums);
                Push(Eval(L, OP, R), nums) ;
                end;  { while }
            Push (X, ops) ;
            end;  { if }
        while Ops.size > 0 do 
    		begin
			Pull(R, nums);
			Pull(L, nums);
			Pull(OP, nums);
            Push(Eval(L, OP, R), nums) ;
            end;  { while }
        end;  { while }
    Answer := top(nums) ;
end;  { proc Precedence }

procedure Brackets(Eq: string; var Answer: element) ;
var
	S, T: stack ;
	X, Mid1, Mid2 : string ;
begin
	while length(Eq) > 0 do
		begin
		Read (Eq, X) ;
		if X <> ')' then push (X, S) ;
		if X = ')' then
			begin
			while top(S) <> '(' do
				begin
				push (Top(S), T) ;
                Pop (S) ;
                end;  { while }
			Pop (S) ;
			Precedence (T, Mid1) ;
			Push (Mid1, S) ;
			end;  { if }
		end;  { while }
	while Top(S) <> nil do
		begin
        Precedence(S, Mid2) ;
        push(Mid2, S) ;
        end;  { while }
	Answer := Top(S) ;
end;  { proc Brackets }

procedure Equation;
var
   eqn: string
begin
   writeln('Enter an equation to be evaluated: ');
   readln(eqn) ;
   brackets(eqn) ;
end;  { proc Equation }

procedure identify_myself ; { Writes who you are to the screen }
begin
   writeln ;
   writeln('CSI 1101-X  (Winter,1999).') ;
   writeln('Mark Sattolo, student# 428500') ;
   writeln('tutorial DGD-4, t.a. = Jensen Boire');
   writeln
end ;

begin  { main program }

  memory_count := 0 ;
  identify_myself ;

repeat
   Equation ;
   writeln('Amount of dynamic memory allocated but not returned (should be 0) ',
   			memory_count:0) ;
   writeln('Do you wish to continue (y or n) ?') ;
   readln(YESorNO);
until (YESorNO in ['y', 'Y'])
end.
