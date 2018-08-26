{ CSI 1101-X,   Winter, 1999 }
{ Assignment 1-P }
{ Identification: Mark Sattolo,  student# 428500 }
{ tutorial group DGD-4,  t.a. = Manon Sanscartier }


program a1 (input,output) ;

label 170;

const
	points_nowhere  = nil ;

type 
      element = real ;
      pointer = ^node ;    
      node  = record
                   	value: element ;
                   	next: pointer
                      end ;
      list = record
                   first: pointer ;
                   size: integer  ;
                end;

{ variable for the main program - NOT to be referenced anywhere else }

var YESorNO: char ;

{************************************************************}

procedure create_empty ( var L: list ) ;	{ sets list L to be empty. }
begin
	L.first := points_nowhere ;
	L.size := 0 ;
end ;


procedure write_list ( var L:list ) ;
var p: pointer ;
begin
  if L.size = 0 then
  	writeln('empty list')
  else
  	begin
        p := L.first ;
        while p <> points_nowhere do
        	begin
                write( ' ', p^.value:7:2 ) ;
                p := p^.next ;
             	end ;  { while }
 	writeln;
 	writeln('Size of List is:  ', L.size, '.') ;
   	end ;  { else }
end ;  { procedure }


procedure insert_at_front(var L:list; V: element) ;
var
	p: pointer;
begin
	New(p) ;
	p^.value := V ;
	p^.next := L.first ;
	L.first := p ;
	L.size := L.size + 1 ;
end;  { procedure }


procedure insert_after_P(var L:list; V: element; P:pointer) ;
var
	q, r : pointer ;
	PointerCheck: boolean ;
begin
	if (L.size = 0) then
		begin
		writeln('Error:  The list provided is empty.') ;
		goto 170 ;	{ halt }
		end  { if }
	else
		begin
		r := L.first ;
		PointerCheck := (p = r) ;
		while (NOT PointerCheck) and (r^.next <> nil) do
			begin
			r := r^.next ;
			PointerCheck := (p = r) ;
			end ; { while }
		if NOT PointerCheck then
			begin
			writeln('Error:  Pointer provided does not point to an element in this list.') ;
			goto 170 ;	{ halt }
			end  { if NOT PtrChk }
		else
			begin
			New(q) ;
			q^.value := V ;
			q^.next := p^.next ;
			p^.next := q ;
			L.size := L.size + 1 ;
			end ;  { else }
		end ;  { else }
end;  { procedure }


procedure pointer_to_Nth(var L:list; N: integer; var P:pointer);
var
	counter: integer;
begin
	if (N < 1) or (N > L.size) then
		begin
		writeln('Error:  Position "', N, '" is outside the range [0 - ', L.size, '] of the list.');
		goto 170;	{ halt }
		end  { if }
	else
		begin
		p := L.first;
		for counter := 1 to N-1 do
			p := p^.next;
		end;  { else }
end;  { procedure }


procedure assignment1 ;
var L:list ;
    P: pointer ;
    position: integer ;
    val: element ;
    done: boolean ;
begin
  create_empty( L ) ;
  repeat
      writeln('enter a position (0 to ', L.size:0, ') and number (empty line to quit)' ) ;
      done := eoln ;
      if not done then
      		begin
             	readln(position, val) ;
             	if position = 0 then
             		insert_at_front(L, val)
             	else
             		begin
                    	pointer_to_Nth(L, position, P);
                    	insert_after_P(L, val, P)
                  	end ;  { else }
             	writeln;
             	writeln('here is the list after this insertion:');
             	write_list( L );
             	writeln;
           	end  { if not done }
       else readln { clear the empty line }
  until done
end;  { procedure }

{**** CHANGE THIS PROCEDURE TO DESCRIBE YOURSELF ****}

procedure identify_myself ;  { Writes who you are to the screen }
begin
   writeln ;
   writeln('CSI 1101-X  (winter, 1999).  Assignment #1-P.') ;
   writeln('Mark Sattolo,  student# 428500.') ;
   writeln('tutorial section DGD-4,  t.a. = Manon Sanscartier');
   writeln
end ;


begin  { main program }
	identify_myself ;
	repeat
		assignment1 ;
170:		writeln('Do you wish to continue (y or n) ?') ;
		readln(YESorNO) ;
	until (YESorNO <> 'y') ;
end.
