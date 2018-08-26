{ CSI 1101-X,   Winter 1999 }
{ Assignment 3 }
{ Identification:  Mark Sattolo,  student# 428500 }
{ tutorial group DGD-4,  t.a. = Manon Sanscartier }

program a3 (input,output) ;

type 
      element_type = real ;
      pointer = ^node ; 
      node    = 	record
                   	  value: element_type ;
                   	  next: pointer
                	end ;
      list = pointer ; 


{ variable for the main program - NOT to be referenced anywhere else }

var YESorNO: char ;

{** The following global variable is used for memory management.
      You might find it useful while debugging your code, but the
      solutions you hand in must not refer to this variable in any way.  **}
     
    memory_count: integer ;


{********  MEMORY MANAGEMENT PROCEDURES  ***********}


{ get_node - Returns a pointer to a new node. }
procedure get_node( var P: pointer );
begin
  memory_count := memory_count + 1 ;
  new( P )
end ;

{ return_node - Make the node pointed at by P "free" (available to get_node). }
procedure return_node(var P: pointer) ;
begin
   memory_count := memory_count - 1 ;
   P^.value  := -7777.77 ;   { "scrub" memory to aid debugging }
   P^.next   := P ;          { "scrub" memory to aid debugging }
   dispose( P )
end ;

{****************************************************************}

{ create_empty - sets list L to be empty. }
procedure create_empty ( var L: list ) ;
begin
    L := nil
end ;


procedure write_list ( var L:list );
var
	p: pointer ;			{ temporary pointer }
	size: integer ;		{ keep track of list size }
begin
  if L = nil then
  	writeln('Empty list.')
  else
  	begin
  	size := 0 ;
        p := L ;
        while p <> nil do			{ traverse list }
        	begin
                write( '  ', p^.value:7:2 ) ;	{ write values }
                p := p^.next ;
                size := size + 1 ;			{ increment size }
             	end ;  { while }
 	writeln;
 	{ writeln('Size of List is:  ', size, '.') ;  // don't want for A3 }
   	end ;  { else }
end ;  { procedure }


procedure insert_at_front(var L:list; V: element_type) ;
var
	p: pointer;			{ temporary pointer }
begin
	get_node(p) ;
	p^.value := V ;		{ new node gets V }
	p^.next := L ;			{ new node continues with rest of list }
	L := p ;				{ list now starts at new node }
end;  { procedure }


procedure insert_after_P( V: element_type; P: pointer) ;
var
	q : pointer ;				{ temporary pointer }
begin
	get_node(q) ;
	q^.value := V ;			{ new node gets V}
	q^.next := p^.next ;		{ new node continues with tail of P }
	p^.next := q ;				{ P now continues with the new node }
end;  { procedure }


procedure destroy( var L:list ) ;
	{ Base case:  L = Nil:  do nothing.
	   General case:  1)  make the recursive call to destroy the 'tail'
	   			     2)  then, return the 'head' node, and all of L has been destroyed. 	}
begin
	if L <> Nil then			{ General case }
		begin
		destroy (L^.next) ;	{ step 1 }
		return_node (L) ;	{ step 2 }
		end					{ i.e.  Base case = "else, do nothing" }
end;  { procedure }


function is_increasing( L:list ): boolean ;
	{ Base case:  L = Nil  or  L = singleton
	  General case:  1)  test the first two values: if (L1 > L2) then the function returns false.
	  			    2)  otherwise make the recursive call to L^.next	}
begin
	if (L = Nil) or (L^.next = Nil) then			{ Base case, gets true }
		is_increasing := true 
	else if L^.value > L^.next^.value then		{ General case, step 1 }
		is_increasing := false 
	else
		is_increasing := is_increasing (L^.next) ;	{ step 2 }
end;  { function }


procedure insert_increasing_rec( var L:list; V: element_type ) ;
	{ Base case:  L is already in increasing order (given), thus if L = Nil or if V <= L1,
				can insert V at the front of L as the first step.
	  General case:  if the base case doesn't hold, make the recursive call to insert V in the 'tail',
	  				and V will be inserted at the correct postion in L.	}
begin
	if (V <= L^.value) or (L = Nil) then			{ Base case }
		insert_at_front (L, V) 
	else
		insert_increasing_rec (L^.next, V) ;		{ General case }
end;  { procedure }


procedure insert_increasing_loop( var L:list; V: element_type ) ;
	{ 1)  L is already in increasing order (given), thus if L = Nil or if V <= L1, can insert V 
		at the front of L as the first step.
	  2)  If cannot insert V at the front of L, need to use 'insert_after_P' and so need to set a
	  	temporary pointer "temp" to traverse the list.
	  3)  Set temp to L initially, then start a loop to move temp to the next node as long as
		there is a next node and it has a value less than V.
	  4)  When the loop has finished, temp is pointing at a node with a value less than V,
	  	where there is no next node or the value of the next node is greater than V, so now
		call 'insert_after_P' with temp and V, and V is inserted in the proper position in L.	}
var
	temp: pointer ;	{ a temporary pointer needed to traverse the list in the while loop }
begin
	if (V <= L^.value) or (L = Nil) then		{ step 1 }
		insert_at_front (L, V) 
	else
		begin
		temp := L ;							{ step 2 }
		while (temp^.next <> Nil) and (V > temp^.next^.value) do
			temp := temp^.next ;				{ step 3 }
		insert_after_P (V, temp) ;				{ step 4 }
		end ;
end;  { procedure }


procedure assignment3 ;
var Lf, Lsr, Lsl: list ;
    val: element_type ;
begin
  create_empty( Lf );
  create_empty( Lsr );
  create_empty( Lsl );
  writeln('enter a list of reals, all values on one line');
  while (not eoln)
  do begin
       read(val) ;
       writeln('inserting this value: ',val:4:1);
       write('at_front:                ');
       insert_at_front(Lf,val) ;
       write_list(Lf);
       write('increasing, recursively: ');
       insert_increasing_rec(Lsr,val) ;
       write_list(Lsr);
       if not is_increasing(Lsr)
       then writeln('*** this list is NOT in increasing order');
       write('increasing, loop:        ');
       insert_increasing_loop(Lsl,val) ;
       if not is_increasing(Lsl)
       then writeln('*** this list is NOT in increasing order');
       write_list(Lsl);
       writeln
     end ;
  readln ; { clear the empty line }

  if is_increasing(Lf)
  then begin
         writeln('*** tricky - you entered the values in decreasing order');
         writeln
       end ;

{ to finish off, return all the nodes in all lists back to the global pool }

  writeln('about to destroy the lists') ;
  destroy( Lf );
  destroy( Lsr );
  destroy( Lsl );
  writeln

end;

{****** YOU MUST CHANGE THIS PROCEDURE TO DESCRIBE YOURSELF ******}

procedure identify_myself ;  { Writes who you are to the screen }
begin
   writeln ;
   writeln('CSI 1101-X  (winter, 1999).  Assignment 3.') ;
   writeln('Mark Sattolo,  student# 428500.') ;
   writeln('tutorial section DGD-4,  t.a. = Manon Sanscartier') ;
   writeln
end ;


begin  { main program }

  memory_count := 0 ;
  identify_myself ;

repeat
  assignment3 ;
  writeln('Amount of dynamic memory allocated but not returned (should be 0) ',
	           memory_count:0) ;
  writeln('Do you wish to continue (y or n) ?') ;
  readln(YESorNO);
until (YESorNO <> 'y')

end.
