program a1test;

(* This program contains 7 test cases to test your implementation.  In order
   to run this program you must create file 'a1unit.pas' and compile it
   to the current directory, or to the C:/work directory.  After compiling
   you should see a file named 'a1unit.tpu' on the disk.

   The program runs 7 labeled tests one by one.  You must hit a key to
   continue after each test.

   NOTE: These tests are by no means exhaustive.  You are encouraged to
   do your own testing as well, as there may still be subtle bugs in your
   code even though they pass the tests here. *)

uses a1unit ; { crt }

var Collection1, Collection2: collection;
{    Value: collection_element;}

begin
   IdentifyMyself;
   writeln;

   (* 1. Test creation of collections *)
   Writeln('1. Create_Collection:');

   Create_Collection(Collection1);
   Create_Collection(Collection2);

   Writeln('Collection1 should be empty (size 0)...');
   Writeln;
   Writeln('Actual contents of Collection1: ');
   Print(Collection1);
   Writeln('Reported Size: ',Size(Collection1));

   Writeln;Readkey;

   (* 2. Test insertion *)
   Writeln('2. INSERTION');

   Insert(Collection1, 'chimpanzee');
   Insert(Collection1, 'orangutan');
   Insert(Collection1, 'gorilla');
   Insert(Collection1, 'bonobo');
   Insert(Collection1, 'human');

   Write ('Collection1 should contain "chimpanzee", "orangutan", "gorilla", ');
   Writeln ('"bonobo", and "human" in any order (Size 5)...');
   Writeln;
   Writeln ('Actual Contents of Collection1:');
   Print(Collection1);
   Writeln;
   Writeln ('Reported size: ', Size(Collection1));

   Writeln;Readkey;

   (* 3. Test Is_Empty *)
   Writeln('3. IS_EMPTY:');

   if not Is_Empty(Collection2) then
      writeln('Collection2 should be empty, but Is_Empty returned FALSE')
   else
      writeln('Collection2 ok');
   if Is_Empty(Collection1) then
      writeln('Collection1 not empty, but Is_Empty returned TRUE')
   else
      writeln('Collection1 ok');
   writeln;Readkey;

   (* 4. Test deletion *)
   Writeln('4. DELETION');

   Delete(Collection1, 'chimpanzee');
   Delete(Collection1, 'human');
   Delete(Collection1, 'hippopotamus');

   Writeln ('Collection1 should contain "orangutan", "gorilla", and "bonobo" in any order (Size 3)...');
   Writeln;
   Writeln ('Actual Contents of Collection1:');
   Print(Collection1);
   Writeln;
   Writeln ('Reported size: ', Size(Collection1));
   writeln;Readkey;

   (* 5. Join with empty collection*)
   Writeln('5. JOIN TO EMPTY COLLECTION:');

   Join(Collection1, Collection2);

   Writeln('Collection1 should be the same as before.');
   Writeln;
   Writeln ('Actual Contents of Collection1:');
   Print(Collection1);
   Writeln;
   Writeln ('Reported size: ', Size(Collection1));
   writeln; readkey;

   (* 6. Join to non-empty collection*)
   Writeln ('6. JOIN TO NON-EMPTY COLLECTION');

   Create_Collection(Collection2);
   If Size(Collection2) <> 0 then
      writeln('Error in re-creation of Collection2');

   Insert(Collection2, 'rhesus monkey');
   Insert(Collection2, 'snow monkey');

   Join(Collection2, Collection1);

   Write ('Collection2 should contain "orangutan", "gorilla", "bonobo", ');
   Writeln ('"snow monkey" and "rhesus monkey" in any order (Size 5)...');
   Writeln;
   Writeln ('Actual Contents of Collection2:');
   Print(Collection2);
   Writeln;
   Writeln ('Reported size: ', Size(Collection2));
   Writeln; readkey;

   (* 7. Destroy and check for memory leak *)
   Writeln('7. MEMCHECK:');

   Destroy(Collection2);
   IF MemCheck then
      writeln('Memory check passed')
   else
      writeln('Memory check failed - possible memory leak');
   writeln;readkey;

   Writeln('*** DONE ***');

end.