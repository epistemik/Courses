{ CSI 1101-X,  Winter, 1999 }
{ Assignment 8 }
{ Identification: Mark Sattolo, student# 428500 }
{ tutorial group DGD-4, t.a. = Jensen Boire }

program a8 (input,output);

const
     maxIDsize = 4 ;  	{ maximum length of identifiers (labels, etc.) }
     maxStatements = 400 ; { maximum number of statements in the assembly language
			     program, not counting comments and empty lines }

     null = '' ;	{ it is easier to distinguish the empty string from a }
     space = ' ' ;	{ one-space string when labels are used for them }

type
    str = string[maxIDsize] ;

    markfile = text ;  { type for text files }


{*********  YOU MAY CHANGE THE FOLLOWING TYPE DEFINITIONS	********}
{*********  The following type definitions can be used		********}
{*********  but you are free to change them providing:		********}
{*********  (1) the Symbol Table and Opcode Table must		********}
{*********	    both be type "table" (they cannot be 	********}
{*********       different types), and  			********}

{*********  (2) the type "table" is a linked data type  	********}
{*********       that uses dynamically allocated memory.  	********}

{ The data type "table" is used for both the Symbol Table and the Opcode Table.
  A table is a linked list in which each node contains a next pointer and two values,
  called "key" and "data".  The key is a string  - in the Opcode Table it will be a symbolic
  mnemonic (e.g. 'ADD'), in the Symbol Table it will be a statement label (e.g. '[1]' or 'X').
  The data value is the numerical value that corresponds to the symbolic key - e.g. in the
  Opcode Table the node that has key='ADD' will have data=99 (99 is the opcode for ADD).
  In the Symbol Table, data will be the numerical memory address that corresponds to
  the label (e.g. if the instruction with statement label '[1]' starts at memory location
  4213, then the Symbol Table node that has key='[1]' will have data=4213. }

    pointer = ^node ;
    node = record
              key: str ;
	      data: str ;  { data changed from 'integer' to 'str' }
	      next: pointer
	   end ;
    table = pointer ;

var
   memory_count: integer;

   infile, outfile : markfile ;
   ASMfile, Machinefile : string ;
   continue : char ;

{ *************** MEMORY MANAGEMENT ************************************  }

{ get_node - Returns a pointer to a new node. }
procedure get_node(var P: pointer) ;
BEGIN
     memory_count := memory_count + 1 ;
     new(P)
END;  { proc get_node }

{ return_node - Make the node pointed at by P "free" (available to get_node). }
procedure return_node(var P: pointer) ;
BEGIN
     memory_count := memory_count - 1 ;
     dispose(P)
END;  { proc return_node }

{ *************************************************************************  }

{ destroy - returns all dynamic memory associated with T }
procedure destroy(var T: table) ;
BEGIN
     if T <> nil then
	BEGIN
	destroy(T^.next) ;
	return_node(T)
	END
END;  { proc destroy }

{ create_empty - create an empty table }
procedure create_empty(var T: table) ;
BEGIN
     T := nil
END;  { proc create_empty }


procedure chop(var S: string) ;
var
   Slen: integer ;
BEGIN
     if (s <> null) then
	BEGIN
	Slen := length(S) ;
	while (S[Slen] = space) do
	     BEGIN
	     delete(S, Slen, 1) ;
	     dec(Slen) ;
	     END  { while }
	END  { if }
END;  { proc chop }

procedure write_table_line(var F: markfile; var T: table) ;
var
   num_add : integer ;
BEGIN
     if T = Nil then
     	writeln('ERROR: Cannot write: Table is empty.')
     else
     	BEGIN
     	write(F, T^.key:4) ;
     	if ( T^.data <> null ) then
           BEGIN
	   { Need Val() instead of ReadString() for TurboPascal }
	   ReadString(T^.data, num_add) ;  
	   write(F, (num_add div 100):3) ;
	   write(F, (num_add mod 100):3) ;
	   END;  { if }
	writeln(F)
	END  { else }
END;  { proc write_table_line }

{ update - given values for "T", "k", and "d", this procedure adds an entry to "T" that
  has "k" as its key part and "d" as its data part.  This procedure may assume that "T"
  does not already contain an entry with key "k" - it does not have to check that
  (however, it might be useful for debugging purposes to handle this error condition). }
procedure update(var T: table; k, d: str) ;
var
   p: pointer ;
BEGIN
     if T = Nil then
   	BEGIN
	get_node(p) ;
	p^.key := k ;
	p^.data := d ;
	p^.next := Nil ;
	T := p
	END  { if }
     else
     	update(T^.next, k, d)
END;  { proc update }

{ lookup - given values for "T" and "k", this procedure searches through "T" for an entry
  that has a key equal to "k" and returns in "answer" the data field (integer value) for
  that entry.  This procedure may assume an entry with key "k" will be found in table "T"
  - it does not have to check that (however, it might be useful for debugging purposes
  to handle this error condition). }
procedure lookup(T: table; k: str; var answer: str) ;
BEGIN
     if T = Nil then
     	writeln('Lookup ERROR: Could not find value ', k, ' in table!')
     else if T^.key = k then
             answer := T^.data
	 else
	     lookup(T^.next, k, answer)
END;  { proc lookup }

{ create_opcode_table - reads "opcode_table" from the file whose DOS/Windows name
  is 'opcodes.dat'.  Each line of opcodes.dat contains:  a mnemonic (string of maxIDsize
  or fewer non-blank characters) starting in column 1, followed by one or more blanks,
  followed by the integer opcode corresponding to the mnemonic. }
procedure create_opcode_table(var opcode_table: table) ;
var
   opfile: markfile ;
   s: string ;
   opkey, opdata : str ;
   space_posn: integer ;
BEGIN
     assign(opfile, 'opcodes.dat') ;
     reset(opfile) ;
     create_empty(opcode_table) ;
     while not EOF(opfile) do
     	BEGIN
     	readln(opfile, S) ;
     	space_posn := pos(space, S) ;
     	opkey := copy(S, 1, (space_posn -1)) ;
     	opdata := copy(S, (length(S) - 1), 2) ;
     	update(opcode_table, opkey, opdata)
     	END;  { while }
     close(opfile)
END;  { proc create_opcode_table }

{ read_asm_line - reads the next line of input (keyboard), and extracts from
  the input line values for "labl", "mnemonic", and "operand".
  Each input line is assumed to be an empty line or a correctly formatted line
  of an assembly language program.  You are NOT REQUIRED to do any input checking.
  If the input line is empty, or is a comment ('/' in column 1), "labl",
  "mnemonic", and "operand" are all set to be the empty string ('').
  If there is a blank (' ') in column 1, "labl" is set to the empty string;
  otherwise "labl" is set to contain the sequence of non-blank characters
  starting in column 1 up to (but not including) the first blank.
  "mnemonic" is set to be the first sequence of non-blank characters beginning
  after the first blank on the line.
  "operand" is set to be the first sequence of non-blank characters beginning
  after the first blank after the end of "mnemonic".  If there is no non-blank
  character after the end of "mnemonic", "operand" is set to the empty string ('').
NOTE: "label" is a keyword in Pascal, so it cannot be used as a variable name. }

procedure read_asm_line(var F: markfile; var labl, mnemonic, operand: str) ;
var
   S, first: string ;
   S_len, mnem, op : integer ;
BEGIN

   repeat
      if EOF(F) then
   	 BEGIN
	 mnemonic := null ;
	 exit
	 END ;
      readln(F, S) ;
      first := S[1] ;
      S_len := length(S) ;
   until
      ( S_len > 0 ) & ( first <> '/' ) ;

   if first = space then
      labl := null
   else
       labl := copy(S, 1, 4) ;
   chop(labl) ;
   mnem := length(labl) + 2 ;
   while (S[mnem] = space) do inc(mnem) ;
   mnemonic := copy(S, mnem, 3) ;
   if ( S_len > (mnem + 2) ) & (S[mnem + 3] <> space) then
      mnemonic := mnemonic + S[mnem + 3] ;
   chop(mnemonic) ;
   op := mnem + length(mnemonic) ;
   while ( op <= S_len ) & ( S[op] = space ) do inc(op) ;
   if ( op > S_len ) then
      operand := null
   else
       operand := copy(S, op, (S_len - op + 1)) ;
   chop(operand)

END;  { proc read_asm_line }

{ assemble - This procedure reads an assembly language program and writes out the
  corresponding machine language program.  For each non-empty, non-comment line of
  assembly language there must be one line of output containing its machine language
  equivalent.  The machine language produced should be in a format that can be read by
  the simulator program (a8sim.pas).
  
  You must follow the two-pass algorithm shown in class.
  
  The main task of the first pass is to create a "symbol table"
  - this is a list that contains:
      - the symbolic statement labels that have occurred in the
        assembly language program,
  and, for each label,
      - the numerical memory address that corresponds to that label
        (assuming the program starts at location 0).

  Conversion of each symbolic mnemonic to the corresponding numerical opcode (by
  looking it up in the opcode table) can be done in the first pass (as in class)
  or on the second pass.  The first pass does nothing with the symbolic operands
  in the assembly language program.  The main task of the second pass is to
  convert these to addresses by looking them up in the symbol table. The second
  pass also prints out the machine language program line by line. }

procedure assemble(var infile, outfile : markfile;  name: string) ;
var
   address, lines : integer ;
   labl, mnemonic, operand, answer, A : str ;
   SymbolTable, OpcodeTable, MachineLang, Surf_ML : table ;

BEGIN
     address := 0 ;   { starting address for the program }
     create_opcode_table(OpcodeTable) ;
     create_empty(SymbolTable) ;

     create_empty(MachineLang) ;
     lines := 0 ;

     {* FIRST PASS: convert mnemonics, build symbol table
     	- need to process differently three types of input line:
     	(1) empty lines and comments
     	(2) lines whose mnemonic is 'BYTE'
     	(3) lines whose mnemonic is in the opcode table. *}

     while ( not EOF(infile) ) & ( lines < maxStatements ) do
     	BEGIN
     	read_asm_line(infile, labl, mnemonic, operand ) ;
     	if ( mnemonic = null ) then break ;
{testing}  writeln('Line read.  labl: ', labl, ' mnem: ', mnemonic, ' op: ', operand) ;

     	if ( labl <> null ) then
           BEGIN
{testing}  writeln('updating SymbolTable: labl = ', labl, ' / address = ', address) ;
	   update(SymbolTable, labl, StringOf(address:4)) ;
	   END;  { if }
	if ( mnemonic = 'BYTE' ) then
	   update(MachineLang, operand, null)
	else
            BEGIN
	    lookup(OpcodeTable, mnemonic, answer) ;
	    update(MachineLang, answer, operand) ;
	    if (operand <> null) then
		address := address + 2
            END;  { else }
	inc(address) ;
	inc(lines)
	END;  { while not EOF }

     if ( lines = maxStatements ) & ( not EOF(infile) ) then
	BEGIN
	writeln('ERROR: ASM program was truncated: # of code lines exceeds maximum: ',
		 maxStatements) ;
	writeln(outfile, '/ ERROR: Processing was terminated: # of lines exceeds maximum: ',
		 maxStatements, ' /') ;
	writeln(outfile)
	END;  { if }

{testing}  writeln('End of first pass.') ;

     {* SECOND PASS:
        look up symbolic operands in the Symbol Table
        (unless the mnemonic is 'BYTE' - the operand for 'BYTE'
        is not a symbol, it is an integer that is to be directly used)
        and write out the machine language program line by line.	*}

     writeln(outfile, '/ CSI 1101-X,  Winter 1999,  Assignment #8 /') ;
     writeln(outfile, '/ Mark Sattolo,  student# 428500 /') ;
     writeln(outfile, '/ tutorial section DGD-4,  t.a. = Jensen Boire /');
     writeln(outfile, '/ Machine language file written by assembler a8 /') ;
     writeln(outfile, '/ Produced from ASM file ''', name, ''' /') ;
     Surf_ML := MachineLang ;
     while Surf_ML <> Nil do
     	  BEGIN
	  A := Surf_ML^.data ;
	  if A <> null then
	     BEGIN
	     lookup(SymbolTable, A, answer) ;
	     Surf_ML^.data := answer ;
	     END;  { if }
	  write_table_line(outfile, Surf_ML) ;
	  Surf_ML := Surf_ML^.next
	  END;  { while }

     destroy(OpcodeTable) ;
     destroy(SymbolTable) ;
     destroy(MachineLang)

END;  { procedure assemble }

procedure identify_myself ;
BEGIN
     writeln ;
     writeln('CSI 1101-X (winter,1999).  Assignment #8.') ;
     writeln('Mark Sattolo,  student# 428500.') ;
     writeln('tutorial section DGD-4,  t.a. = Jensen Boire');
     writeln
END ;

BEGIN { main program }

repeat
      writeln('Please enter the name of the file with the ASM code.') ;
      readln(ASMfile) ;
      assign(infile, ASMfile) ;
      reset(infile) ;
      writeln('Please enter a name to give the machine code file.') ;
      readln(Machinefile) ;
      assign(outfile, Machinefile) ;
      rewrite(outfile) ;

      identify_myself ;
      memory_count := 0 ;
      assemble(infile, outfile, ASMfile) ;
      writeln('Amount of dynamic memory allocated but not returned (should be 0) ',
               memory_count:0) ;
      close(infile) ;
      close(outfile) ;
      writeln('Do you wish to process another file [ y or n ] ?') ;
      readln(continue) ;
      if ( continue in ['n', 'N'] ) then
      	 writeln('PROGRAM ENDED - have a nice day!')
      else
      	  writeln('========================================')
until
     continue in ['n', 'N']
END.

