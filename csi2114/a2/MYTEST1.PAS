program a2test1;

{ This program contains 8 test cases to test your implementation.  In order
   to run this program you must compile the files 'a2unit.pas' and 'BinTrADT.pas'
   to the current directory, or to the C:/work directory.  After compiling
   you should see files named 'a2unit.tpu' and 'BinTrADT.tpu' on the disk.

   The program runs 8 labeled tests one by one.  You must hit enter to
   continue after each test.

   NOTE: These tests are by no means exhaustive.  You are encouraged to
   do your own testing as well, as there may still be subtle bugs in your
   code even though they pass the tests here.  }

uses a2unit, BinaryTreeADT;

var Collection1, Collection2: collection;
 {   Value: collection_element; }

begin
   (* 1. Test creation of collections *)
   Writeln('1. Create_Collection:');

   Create_Collection(Collection1);
   Create_Collection(Collection2);

   Writeln('Collection1 should be empty (size 0)...');
   Writeln;
   Writeln('Actual contents of Collection1: ');
   Print(Collection1);
   Writeln('Reported Size: ',Size(Collection1));

   Writeln;Readln;

   (* 2. Test insertion *)
   Writeln('2. INSERTION');

   Insert(Collection1, 'chimpanzee');
   Insert(Collection1, 'orangutan');
   Insert(Collection1, 'gorilla');
   Insert(Collection1, 'bonobo');
   Insert(Collection1, 'human');
   Insert(Collection1, 'tapir');
   Insert(Collection1, 'gerbil');

   Write ('Collection1 should contain "chimpanzee", "orangutan", "gorilla", ');
   Writeln ('"bonobo", "human", "tapir", and "gerbil" in sorted order (Size 7)...');
   Writeln;
   Writeln ('Actual Contents of Collection1:');
   Print(Collection1);
   Writeln;
   Writeln ('Reported size: ', Size(Collection1));

   Writeln;readln;

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
   writeln;Readln;

   (* 4. Test deletion *)
   Writeln('4. DELETION');

   Delete(Collection1, 'chimpanzee');
   Delete(Collection1, 'gorilla');
   Delete(Collection1, 'hippopotamus');

   Writeln ('Collection1 should contain "orangutan", "human", "bonobo", "gerbil", and "tapir" in sorted order (Size 5)...');
   Writeln;
   Writeln ('Actual Contents of Collection1:');
   Print(Collection1);
   Writeln;
   Writeln ('Reported size: ', Size(Collection1));
   writeln;Readln;

   (* 5. Join with empty collection*)
   Writeln('5. JOIN TO EMPTY COLLECTION:');

   Join(Collection1, Collection2);

   Writeln('Collection1 should be the same as before.');
   Writeln;
   Writeln ('Actual Contents of Collection1:');
   Print(Collection1);
   Writeln;
   Writeln ('Reported size: ', Size(Collection1));
   writeln; readln;

   (* 6. Join to non-empty collection*)

   Writeln ('6. JOIN TO NON-EMPTY COLLECTION');

   Writeln ('Re-creating Collection2');
   Create_Collection(Collection2);
   If Size(Collection2) <> 0 then
      writeln('Error in re-creation of Collection2');

   Insert(Collection2, 'rhesus monkey');
   Insert(Collection2, 'snow monkey');
   Insert(Collection2, 'marmoset');
   Writeln ('Collection2 should contain "snow monkey", "rhesus monkey", and "marmoset" in sorted order (Size 3)...');
   Writeln;
   Writeln ('Actual Contents of Collection2:');
   Print(Collection2);
   Writeln;
   Writeln ('Reported size: ', Size(Collection2));
   Writeln; readln;

   Join(Collection2, Collection1);

   Write ('Collection2 should contain "orangutan", "human", "bonobo", "gerbil", "tapir", ');
   Writeln ('"snow monkey", "rhesus monkey", and "marmoset" in sorted order (Size 8)...');
   Writeln;
   Writeln ('Actual Contents of Collection2:');
   Print(Collection2);
   Writeln;
   Writeln ('Reported size: ', Size(Collection2));
   Writeln; readln;

   (* 7. One More Deletion*)

   Writeln ('7. ANOTHER DELETION');

   Delete(Collection2, 'gerbil');

   Write ('Collection2 should contain "orangutan", "human", "bonobo", "tapir", ');
   Writeln ('"snow monkey", "rhesus monkey", and "marmoset" in sorted order (Size 7)...');
   Writeln;
   Writeln ('Actual Contents of Collection2:');
   Print(Collection2);
   Writeln;
   Writeln ('Reported size: ', Size(Collection2));
   Writeln; readln;

   (* 8. Destroy and check for memory leak *)
   Writeln('8. MEMCHECK:');

   Destroy(Collection2);
   IF MemCheck then
      writeln('Memory check passed')
   else
      writeln('Memory check failed - possible memory leak');
   writeln;readln;

   Writeln('*** DONE ***');

end.