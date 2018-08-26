{ CSI 1101-X,   Winter, 1999 }
{ Assignment 1 }
{ Identification: Mark Sattolo,  student# 428500 }
{ tutorial group DGD-4,  t.a. = Manon Sanscartier }


program a1 (input,output) ;

label 185;

const
	max_list_length = 20 ;
	points_nowhere  = -9999 ;

type 
      element_type = real ;
      pointer = integer ;    { array index }
      node  = record
                   	value: element_type ;
                   	next: pointer
                      end ;
      list = record
      		   nodes: array [1..max_list_length] of node ;
                   first: pointer ;
                   size: integer  ;
                end;

{ variable for the main program - NOT to be referenced anywhere else }

var YESorNO: char ;

{************************************************************}

{ create_empty  -  sets list L to be empty. }

procedure create_empty ( var L: list ) ;
begin
    L.first := points_nowhere ;
    L.size := 0 ;
end ;


procedure write_array_order ( var L:list );
var i,j,rowsize: integer ;
begin
  for j := 1 to (L.size div 8)+1
  do begin
       if (j*8) <= L.size
       then rowsize := 8
       else rowsize := L.size - ((j-1)*8) ;
       write('index: ');
       for i := 1 to rowsize do write( (j-1)*8+i:5,' ');
       writeln;
       write('value: ');
       for i := 1 to rowsize do write( L.nodes[(j-1)*8+i].value:5:1,' ');
       writeln;
       write(' next: ');
       for i := 1 to rowsize do write( L.nodes[(j-1)*8+i].next:5,' ');
       writeln
     end
end ;


procedure write_list ( var L:list );
var p: pointer ;
begin
  if L.size = 0
  then writeln('empty list')
  else begin
          p := L.first ;
          while p <> points_nowhere
          do begin
                write( ' ',L.nodes[p].value:3:1 );
                p := L.nodes[p].next
             end ;
          writeln
       end
end ;


procedure insert_at_front(var L:list; V: element_type) ;
var
	P: pointer;
begin
	P := L.size + 1;
	L.nodes[p].value := V;
	L.nodes[p].next := L.first;
	L.first := P;
	L.size := L.size + 1;
end;  { procedure }


procedure insert_after_P(var L:list; V: element_type; P:pointer) ;
var
	Q: pointer;
begin
	if (L.size = 0) then
		begin
		writeln('Error:  The list provided is empty.');
		goto 185;	{ halt }
		end  { if }
	else if (P > L.size) or (P < 1) then
		begin
		writeln('Error:  Pointer "', P, '" does not point to an element in this list.');
		goto 185;	{ halt }
		end  { else if }
		else
			begin
			Q := L.size + 1;
			L.nodes[q].value := V;
			L.nodes[q].next := L.nodes[p].next;
			L.nodes[p].next := Q;
			L.size := L.size + 1;
			end;  { else }
end;  { procedure }


procedure pointer_to_Nth(var L:list; N: integer; var P:pointer);
var
	counter: integer;
begin
	if (N < 1) or (N > L.size) then
		begin
		writeln('Error:  Position "', N, '" is outside the range [0 - ', L.size, '] of the list.');
		goto 185;	{ halt }
		end  { if }
	else
		begin
		P := L.first;
		for counter := 1 to N-1 do
			P := L.nodes[p].next;
		end;  { else }
end;  { procedure }


procedure assignment1 ;
var L:list ;
    P: pointer ;
    position: integer ;
    val: element_type ;
    done: boolean ;
begin
  create_empty( L );
  repeat
      writeln('enter a position (0 to ',L.size:0, ') and number (empty line to quit)' ) ;
      done := eoln ;
      if not done
      then begin
             readln(position,val) ;
             if position = 0
             then insert_at_front(L,val)
             else begin
                    pointer_to_Nth(L,position,P);
                    insert_after_P(L,val,P)
                  end ;

             writeln;
             writeln('here is the list after this insertion:');
             write_list( L );
             writeln;
             writeln('Here is the array used to represent the list:');
             write_array_order( L )
           end
       else readln { clear the empty line }
  until done
end;

{**** CHANGE THIS PROCEDURE TO DESCRIBE YOURSELF ****}

procedure identify_myself ;  { Writes who you are to the screen }
begin
   writeln ;
   writeln('CSI 1101-X  (winter, 1999).  Assignment #1.') ;
   writeln('Mark Sattolo,  student# 428500.') ;
   writeln('tutorial section DGD-4,  t.a. = Manon Sanscartier');
   writeln
end ;


begin  { main program }
	identify_myself ;
	
	repeat
		assignment1 ;
185:		writeln('Do you wish to continue (y or n) ?') ;
		readln(YESorNO);
	until (YESorNO <> 'y');
	
end.
