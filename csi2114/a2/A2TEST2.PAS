Program a2test2;

{This program uses the same units as a1test, but it gives you a menu interface to
 manage two collections (c1 and c2).  You can insert, delete, join, print and
 get the size of either collection.  Use this to test your code during development.
 Make sure you hand in a compiled version of this program too.}

uses BinTrADT, a2unit;

var C1,C2: collection;
    choice: integer;
    s: collection_element;

begin
   IdentifyMyself;
   writeln;

   create(c1);
   create(c2);

   repeat
      writeln;
      writeln('1. Insert into C1,');
      writeln('2. Insert into C2,');
      writeln('3. Delete from C1,');
      writeln('4. Delete from C2,');
      writeln('5. Join C1 to C2,');
      writeln('6. Get size of C1,');
      writeln('7. Get size of C2,');
      writeln('8. Print C1,');
      writeln('9. Print C2,');
      writeln('10. quit');
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
            Writeln('Joining C1 to C2, and calling create(C2) again');
            Writeln('Now C1 contains all elements from C1 and C2, and C2 is empty');
            Join(C1, C2);
            Create(C2);
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
      end;

   until (choice = 10);

   destroy(c1); destroy(C2);
   writeln('C1 and C2 destroyed');

   IF MemCheck then
      writeln('Memory check passed')
   else
      writeln('Memory check failed - possible memory leak');

   writeln;
   writeln('Bye Bye...');
end.
