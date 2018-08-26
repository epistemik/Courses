{ CSI 1101-X,   Winter, 1999 }
{ Assignment 2 }
{ Identification: Mark Sattolo,  student# 428500 }
{ tutorial group DGD-4,  t.a. = Manon Sanscartier }

program a2 (input,output) ;

label 190;

type 
      element_type = real ;
      pointer = ^node ;          { CHANGED FROM ASSIGNMENT #1 }
      node = record
                	value: element_type ;
        		next: pointer
             	    end ;
      list = pointer ;           { CHANGED FROM ASSIGNMENT #1 }


{ variable for the main program - NOT to be referenced anywhere else }

var YESorNO: char ;

{ The following global variable is used for memory management.  
  You might find it useful while debugging your code, but the
  solutions you hand in must not refer to this variable in any way. }
  
  memory_count: integer ;


{****** MEMORY MANAGEMENT PROCEDURES *********}

procedure get_node( var P: pointer );	{ Returns a pointer to a new node. }
begin
	memory_count := memory_count + 1 ;
	new( P )
end ;

{ return_node - Make the node pointed at by P "free" (available to get_node). }
procedure return_node(var P: pointer) ;  { parameter L not needed }
begin
	memory_count := memory_count - 1 ;
	P^.value  := -9999.99 ;   { "scrub" memory to aid debugging }
	dispose( P )
end ;

{************************************************************}

procedure create_empty ( var L: list ) ;	{ Sets list L to be empty. }
begin
	L := nil
end ;

procedure write_list ( var L:list );
var
	p: pointer ;
	size: integer ;
begin
  if L = nil then
  	writeln('Empty list.')
  else
  	begin
  	size := 0 ;
        p := L ;
        while p <> nil do
        	begin
                write( ' ', p^.value:7:2 ) ;
                p := p^.next ;
                size := size + 1 ;
             	end ;  { while }
 	writeln;
 	writeln('Size of List is:  ', size, '.') ;
   	end ;  { else }
end ;  { procedure }

procedure delete_first (var L:list) ;
var
	p: pointer ;
begin
	if L = nil then
		begin
		writeln('Error:  List is empty') ;
		goto 190 ;  { halt } 
		end  { if }
	else
		begin
		p := L ;
		L := p^.next ;
		return_node(p) ;
		end  { else }
end;  { procedure }

procedure pointer_to_Nth(var L:list; N: integer; var P:pointer);
var
	counter, size: integer;
begin
  	size := 0 ;
        p := L ;
        while p <> nil do
        	begin
                p := p^.next ;
                size := size + 1 ;
             	end ;  { while }
	if (N < 1) or (N > size) then
		begin
		writeln('Error:  Position "', N, '" is outside the range [0 - ', size, '] of the list.') ;
		while L <> nil do delete_first( L ) ;
		goto 190 ;  { halt } 
		end  { if }
	else
		begin
		p := L ;
		for counter := 1 to N-1 do
			p := p^.next ;
		end;  { else }
end;  { procedure }

procedure insert_at_front(var L:list; V: element_type) ;
var
	p: pointer;
begin
	get_node(p) ;
	p^.value := V ;
	p^.next := L ;
	L := p ;
end;  { procedure }

procedure insert_after_P( V: element_type; P: pointer) ;
var
	q : pointer ;
begin
	get_node(q) ;
	q^.value := V ;
	q^.next := p^.next ;
	p^.next := q ;
end;  { procedure }

procedure assignment2 ;
var L: list ;
    P: pointer ;
    position: integer ;
    val: element_type ;
    done: boolean ;
begin
  create_empty( L );
  repeat
      writeln('Enter a position (0 to current list length)',
      			' and a number (empty line to quit):  ' ) ;
      done := eoln ;
      if not done
      then begin
             readln(position,val) ;
             if position = 0
             then insert_at_front(L,val)
             else begin
                    pointer_to_Nth(L,position,P);
                    insert_after_P(val,P)
                  end ;

             writeln;
             writeln('Here is the list after this insertion: ');
             write_list( L );
             writeln
           end
       else readln { clear the empty line }
  until done ;

{ to finish off, return all the nodes in L back to the global pool }

  while L <> nil do delete_first( L )

end;  { procedure }

{**** YOU MUST CHANGE THIS PROCEDURE TO DESCRIBE YOURSELF ****}

procedure identify_myself ;  { Writes who you are to the screen }
begin
   writeln ;
   writeln('CSI 1101-X  (winter, 1999).  Assignment 2.') ;
   writeln('Mark Sattolo,  student# 428500.') ;
   writeln('tutorial section DGD-4,  t.a. = Manon Sanscartier');
   writeln
end ;  { procedure }

begin  { main program }
	memory_count := 0 ;
	identify_myself ;
  repeat
	assignment2 ;
190:	writeln('Amount of dynamic memory allocated but not returned (should be 0) ', memory_count:0) ;
	writeln('Do you wish to continue (y or n) ?') ;
  	readln(YESorNO);
  until (YESorNO <> 'y')
end.
