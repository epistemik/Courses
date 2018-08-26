Program a2test2;

{This program uses the same units as a1test, but it gives you a menu interface to
 manage two collections (c1 and c2).  You can insert, delete, join, print and
 get the size of either collection.  Use this to test your code during development.
 Make sure you hand in a compiled version of this program too.}

uses BinaryTreeADT, a2unit;

Procedure Peek(C: Collection);
begin
	If not Is_Empty(C) then BEGIN
		write('V: ',Get_Root_Value_BT(C),',  ');
		If not Is_Empty_BT(Parent_BT(C)) then
			write('P: ',Get_Root_Value_BT(Parent_BT(C)),',  ')
		else
			write('P: NIL,  ');
		If not Is_Empty_BT(LeftChild_BT(C)) then
			write('L: ',Get_Root_Value_BT(LeftChild_BT(C)),',  ')
		else
			write('L: NIL,  ');
		If not Is_Empty_BT(RightChild_BT(C)) then
			write('R: ',Get_Root_Value_BT(RightChild_BT(C)),'.')
		else
			write('R: NIL.');
		writeln;
		Peek(LeftChild_BT(C));
		Peek(RightChild_BT(C))
		END { if }
end;

procedure Last( C: collection; var LastPtr: BinaryTree ) ;

	procedure FindLast( T: collection; depth: integer; var max_depth: integer; var LastPtr: binarytree ) ;
	begin
		if not Is_Empty_BT(T) then BEGIN
			inc(depth) ;
			if ( depth > max_depth ) then BEGIN
				max_depth := depth ;
				LastPtr := T 
				END
			else if ( depth = max_depth ) & ( Get_Root_Value_BT(T) > Get_Root_Value_BT(LastPtr) )
					then LastPtr := T ;
			FindLast( LeftChild_BT(T), depth, max_depth, LastPtr) ;
			FindLast( RightChild_BT(T), depth, max_depth, LastPtr) ;
			END  { if }
	end;  { private proc FindLast }

var
	depth, max_depth: integer ;
begin
	depth := 0 ;
	max_depth := 0 ;
	LastPtr := NIL ;
	FindLast( C, depth, max_depth, LastPtr )
end;  { proc Last }	

procedure TreeFlip( var T: collection ) ;
var  temp: BinaryTree ;
begin
	if not Is_Empty_BT(T) then BEGIN
		TreeFlip( LeftChild_BT(T) ) ;
		TreeFlip( RightChild_BT(T) ) ;
		temp := T^.RightChild ;
		T^.RightChild := T^.LeftChild ;
		T^.LeftChild := temp ;
		END { if not }
end;  { proc TreeFlip }

var
	C1,C2: collection;
	choice: integer;
	s: collection_element ;
	LastPtr: BinaryTree ;

begin
   Create_Collection(c1);
   Create_Collection(c2);

   repeat
      writeln;
      write(' 1. Insert into C1,      ');
      writeln('2. Insert into C2,');
      write(' 3. Delete from C1,      ');
      writeln('4. Delete from C2,');
      write(' 5. Join C2 to C1,      ');
      writeln('55. Join C1 to C2.') ;
      write(' 6. Get size of C1,      ');
      writeln('7. Get size of C2,');
      write(' 8. Print C1,            ');
      writeln('9. Print C2,');
      write('10. Peek at C1,         ');
      writeln('11. Peek at C2,      ');
      write('12. Get Last C1,        ');
      writeln('13. Get Last C2,');
      write('14. TreeFlip C1,        ');
      writeln('15. TreeFlip C2,      ');
      writeln('99. QUIT');
      writeln; readln(choice);

      case choice of
         1: begin
            Write('String to insert into C1: '); readln(s);
            Insert(C1, s);
         end;

         2: begin
            Write('String to insert into C2: '); readln(s);
            Insert(C2, s);
         end;

         3: begin
            Write('String to delete from C1: '); readln(s);
            Delete(C1, s);
         end;

         4: begin
            Write('String to delete from C2: '); readln(s);
            Delete(C2, s);
         end;

         5: begin
            Writeln( 'Joining C2 to C1, and creating a new empty C2. ' );
            Writeln( 'C1 now contains all the elements that were in C1 and C2. ' );
            Join(C1, C2);
            Create_Collection(C2);
         end;

        55: begin
            Writeln( 'Joining C1 to C2, and creating a new empty C1. ' );
            Writeln( 'C2 now contains all the elements that were in C1 and C2. ' );
            Join(C2, C1);
            Create_Collection(C1);
         end;

         6: begin  Writeln('C1 has ',Size(C1),' elements');   end;

         7: begin  Writeln('C2 has ',Size(C2),' elements');   end;

         8: begin
            Writeln( 'Contents of C1: ' );
            Print(C1);
         end;

         9: begin
            Writeln( 'Contents of C2: ' );
            Print(C2);
         end;
		
         10: begin
		if not is_empty(C1) then Peek(C1)
			else writeln( 'C1: Empty collection.' ) ;
		end;
		
         11: begin
		if not is_empty(C2) then Peek(C2)
			else writeln( 'C2: Empty collection.' ) ;
		end;
		
         12: begin Last(C1, LastPtr) ;
				if Is_empty(LastPtr) then writeln('C1: Empty collection.')
					else writeln( 'Last C1: ', Get_Root_Value_BT(LastPtr) )
		end;
		
         13: begin Last(C2, LastPtr) ;
				if Is_empty(LastPtr) then writeln('C2: Empty collection.')
					else writeln( 'Last C2: ', Get_Root_Value_BT(LastPtr) )
		end;
		
         14: begin TreeFlip(C1) ;
				if is_empty(C1) then writeln('C1: Empty collection.')
					else writeln( 'Tree C1 has been flipped!' )
		end;
		
         15: begin TreeFlip(C2) ;
				if is_empty(C2) then writeln('C2: Empty collection.')
					else writeln( 'Tree C2 has been flipped!' )
		end;

      end; { case }

   until (choice = 99) ;

   destroy(C1); destroy(C2);
   writeln( 'C1 and C2 destroyed.' );

   if MemCheck then writeln( 'Memory check passed!' )
   	else writeln( 'Memory check FAILED - possible memory leak!!' );

   writeln;
   writeln('Bye Bye...');
end.
