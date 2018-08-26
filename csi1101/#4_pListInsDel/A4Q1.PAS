{ CSI 1101-X,   Winter 1999 }
{ Assignment 4,  Question 1 }
{ Identification:  Mark Sattolo,  student# 428500 }
{ tutorial group DGD-4,  t.a. = Manon Sanscartier }

program a4q1 (input,output) ;

type
      element_type = real ;
      pointer = ^node ; 
      node = record
                	value: element_type ;
			next: pointer
			end ;
      list = pointer ; 

(* variable for the main program - NOT to be referenced anywhere else *)

var YESorNO: char ;

(*** The following global variable is used for memory management.
     You might find it useful while debugging your code, but the
     solutions you hand in must not refer to this variable in any way.
***)
    memory_count: integer ;


(********* MEMORY MANAGEMENT PROCEDURES ************)

(* get_node - Returns a pointer to a new node. *)

procedure get_node( var P: pointer );
begin
  memory_count := memory_count + 1 ;
  new( P )
end ;

(* return_node - Make the node pointed at by P "free"
                 (available to get_node).
*)
procedure return_node(var P: pointer) ;
begin
   memory_count := memory_count - 1 ;
   P^.value  := -7777.77 ;   (* "scrub" memory to aid debugging *)
   P^.next   := P ;          (* "scrub" memory to aid debugging *)
   dispose( P )
end ;

(******************************************************************)

(* create_empty - sets list L to be empty. *)

procedure create_empty ( var L: list ) ;
begin
    L := nil
end ;

procedure write_list ( var L:list );
var p: pointer ;
begin
  if L = nil
  then writeln('empty list')
  else begin
          p := L ;
          while p <> nil
          do begin
                write( ' ',p^.value:4:1 );
                p := p^.next
             end ;
          writeln
       end
end ;

procedure destroy( var L:list ) ;
begin
	if L <> Nil then			{ General case }
		begin
		destroy (L^.next) ;	{ step 1 }
		return_node (L) ;	{ step 2 }
		end					{ i.e.  Base case = "else, do nothing" }
end;  { procedure }


procedure insert_at_end(var L:list; V: element_type) ;
begin
	if L = nil then
		begin
		get_node(L) ;
		L^.value := V ;
		L^.next := nil ;
		end  { if }
	else
		insert_at_end(L^.next, V) ;
end;  { procedure }

procedure delete_all_occurrences( var L:list; V: element_type) ;
var
	p : pointer ;
begin
	if L = nil then 
		{ do nothing }
	else
		begin
		delete_all_occurrences(L^.next, V) ; 
		if (L^.value = V) then
			begin
			p := L ;
			L := L^.next ;
			return_node(p) ;
			end  { if }
		end  { else }
end;  { procedure }
		

procedure assignment4q1 ;
var L: list ;
    val: element_type ;
begin
  create_empty( L );
  writeln('enter a list of reals, all values on one line');
  while (not eoln)
  do begin
       read(val) ;
       insert_at_end(L,val)
     end ;
  readln ; (* clear the empty line *)

  writeln ;
  writeln('Here is the list you entered');
  write_list(L);
  writeln ;

  writeln('enter a value to be deleted (empty line to quit)' );
  while (not eoln)
  do begin
       readln(val) ;
       delete_all_occurrences(L, val) ;
       writeln('Here is the list after deleting all occurrences of ',val:6:1);
       write_list(L);
       writeln ;
       writeln('enter a value to be deleted (empty line to quit)' )
     end ;
  readln ; (* clear the empty line *)

(* to finish off, return all the nodes in all lists back to the global pool *)
  destroy( L )
end;

(******* YOU MUST CHANGE THIS PROCEDURE TO DESCRIBE YOURSELF *******)

procedure identify_myself ; (*    Writes who you are to the screen *)
begin
   writeln ;
   writeln('CSI 1101-X  (winter, 1999).  Assignment 4, Question 1.') ;
   writeln('Mark Sattolo,  student# 428500.') ;
   writeln('tutorial section DGD-4,  t.a. = Manon Sanscartier') ;
   writeln
end ;


begin  { main program }

  memory_count := 0 ;
  identify_myself ;

repeat
  assignment4q1 ;
  writeln('Amount of dynamic memory allocated but not returned (should be 0) ',
           memory_count:0) ;

  writeln('Do you wish to continue (y or n) ?') ;
  readln(YESorNO);
until (YESorNO <> 'y')

end.


