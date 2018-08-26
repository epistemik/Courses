Program a3test1;

{ This program gives you a menu interface to manage two collections (c1 and c2). 
  You can insert, delete, join, print and  get the size of either collection.  Use this to test your code.
  Make sure you hand in a compiled version of this program.

 NOTE: There is a new function here called "Peek".  This lets you cheat and look at the internal
 		   structure of your collection (tree).  The output is one line for each node, using a preorder
 		   traversal.  Each line looks like this:

V: <value>, B: <balance>, P: <parent node>, L: <Left child>, R: <Right Child>

	You can use this function to test your rotations and make sure everything works properly. }

uses btadt, a3unit;

Procedure Peek(C: Collection);
begin
   If not Is_Empty(C) then begin
      write('V: ',Get_Root_Value_BT(C),',  ');
      write('B: ',Get_Balance_Field_BT(C),',  ');
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
  end
end;

var C1,C2: collection;
    choice: integer;
    s: collection_element;

begin
   create(c1);
   create(c2);

   repeat
      writeln;
      write('1. Insert into C1,      ');
      writeln('2. Insert into C2,');
      write('3. Delete from C1,      ');
      writeln('4. Delete from C2,');
      write('5. Join C2 to C1,       ');
      writeln('55. Join C1 to C2.') ;
      write('6. Get size of C1,      ');
      writeln('7. Get size of C2,');
      write('8. Print C1,            ');
      writeln('9. Print C2,');
      write('10. Peek at C1,         ');
      write('11. Peek at C2,      ');
      writeln('12. quit');
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
            Writeln('Joining C2 to C1, and calling create(C2) again');
            Writeln('Now C1 contains all elements from C1 and C2, and C2 is empty');
            Join(C1, C2);
            Create(C2);
         end;

         55: begin
            Writeln('Joining C1 to C2, and calling create(C1) again');
            Writeln('Now C2 contains all elements from C1 and C2, and C1 is empty');
            Join(C2, C1);
            Create(C1);
         end;

         6: begin
            Writeln('C1 has ',Size(C1),' elements');
         end;

         7: begin
            Writeln('C2 has ',Size(C2),' elements');
         end;

         8: begin
            Writeln('Contents of C1:');
            writeln;
            Print(C1);
         end;

         9: begin
            Writeln('Contents of C2:');
            writeln;
            Print(C2);
         end;

         10: begin
            Peek(C1);
 {           writeln('PRESS ENTER');
            readln;
  }       end;

         11: begin
            Peek(C2);
   {         writeln('PRESS ENTER');
            readln;
    }     end;
  
      end;

   until (choice = 12);

   destroy(c1); destroy(C2);
   writeln('C1 and C2 destroyed');

   IF MemCheck then
      writeln('Memory check passed')
   else
      writeln('Memory check failed - possible memory leak');

   writeln;
   writeln('Bye Bye...');
end.
