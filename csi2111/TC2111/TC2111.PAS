(*************************************************)
(** CSI 2111 (October,1995).   TC2111           **)
(*************************************************)

program tc2111 (input, output) ;

uses    Crt;            (* Under Windows:  uses WinCrt *)

(* the following constants give symbolic names for the opcodes *)

const   lda = $0091 ;   (* Load  Accumulator from memory *)
        sta = $0039 ;   (* Store Accumulator into memory *)
        cla = $0008 ;   (* Clear (set to zero)  the Accumulator *)
        inc = $0010 ;   (* Increment (add 1 to) the Accumulator *)
        add = $0099 ;   (* Add to the Accumulator *)
        cp2 = $0060 ;   (* (2's) Complement the Accumulator *)
        jmp = $0015 ;   (* Jump ("go to ")  *)
        jz  = $0017 ;   (* Jump if the Zero     status bit is TRUE *)
        jn  = $0019 ;   (* Jump if the Negative status bit is TRUE *)
        dsp = $0001 ;   (* Display (write on the screen) *)
        hlt = $0064 ;   (* Halt *)

(* Size of manipulated data *)
        byteSize = false;
        wordSize = true;

type bit  = boolean  ;
     byte = $00..$FF ;        (*    $80..$7F  , in 2's CF  *)
     word = $0000..$FFFF ;    (*  $8000..$7FFF, in 2's CF  *)
     memorySize = $0000..$1000;

var
    program_name: string;
    input_file: text  ; (* Your machine language program *)

    memory: array[memorySize] of byte ;

                     (* the following are the registers in the CPU *)
    pc:      word ;  (* Program Counter *)
    a:       word ;  (* Accumulator     *)
    opCode:  word ;  (* the OPCODE of the current instruction *)
    opAddr:  word ;  (* the ADDRESS of the operand of the current instruction *)
    z:       bit  ;  (* "Zero" status bit *)
    n:       bit  ;  (* "Negative" status bit *)
    h:       bit  ;  (* "Halt" status bit     *)

    mar:     word ;  (* Memory Address Register *)
    mdr:     word ;  (* Memory Data    Register *)
    rw:      bit  ;  (* Read/Write bit.  Read = True; Write = False *)
    ds:      bit  ;  (* Data Size bit. ByteSize = false; WordSize = true *)

(***************************************************************************)

function Int2Hex(int: word) : string;
(* Converts an integer to an hexadecimal string *)
var
   hexDigit : byte;
   hexString: string ;
begin
   hexDigit := int MOD 16;
   if hexDigit < $A
      then hexString := chr(48+hexDigit)
      else hexString := chr(55+hexDigit);

   if int >= 16
      then hexString := Int2Hex (int DIV 16) + hexString;

   Int2Hex := hexString
end;

(***************************************************************************)

procedure loader ;
(* Reads a machine language program into memory from a file *)
var address: word ;
    first_character, ch: char ;
begin
   address := $0000 ;
   while (not eof(input_file))
   do begin
         read(input_file,first_character);
         if first_character <> ' '   (* non-blank indicates a comment *)
         then repeat                 (* skip over comment *)
                 read(input_file,ch)
              until (ch = first_character) or eoln(input_file) ;
         while (not eoln(input_file))
         do begin
               read(input_file,memory[address]) ;
               address := address + $0001
            end ;
         readln(input_file)
      end;
   writeln ('Program loaded. ', address,' bytes in memory.');
end ;

(***************************************************************************)

procedure  access_memory;
begin
   if rw
   then begin
        (* TRUE  = read = copy a value from memory into the CPU *)
           if ds = byteSize
           then mdr := memory[mar]
           else (* wordSize *) mdr := memory[mar] * $100 + memory[mar+1];
        end
   else begin
        (* FALSE = write = copy a value into memory from the CPU *)
           if ds = byteSize
           then memory[mar] := mdr MOD $100       (* LSB *)
           else begin  (* wordSize *)
                   memory[mar] := mdr DIV $100;   (* MSB *)
                   memory[mar+1] := mdr MOD $100; (* LSB *)
                end
        end
end ;

(***************************************************************************)

procedure controller ;
(* This implements the Fetch-Execute cycle *)
begin
   pc := $0000 ;  (* always start execution at location $0000 *)
   h  := false ;  (* clear the Halt status bit *)
   repeat
   (* FETCH OPCODE *)
       mar := pc         ;
       ds  := wordSize   ;  (* OpCodes are Words *)
       pc  := pc + $0002 ;  (* NOTE that pc is incremented immediately *)
       rw  := true       ;  (* Read *)
       access_memory     ;
       opCode := mdr     ;  (* OpCode fetched from memory. *)

   (* If the opcode is odd, it needs an operand. *)
   (* FETCH THE ADDRESS OF THE OPERAND *)
       if (opCode mod 2) = $0001   (* odd *)
       then begin
               mar := pc        ;
               ds  := wordSize  ;
               pc  := pc + $0002;(* NOTE that pc is incremented immediately *)
               rw  := true      ;
               access_memory    ;
               opAddr := mdr     (* opAddr fetched from memory *)
            end ;


    (* EXECUTE THE OPERATION *)
       case opCode of

       lda: begin
              mar := opAddr   ;   (* Get the Operand's value from memory *)
              rw  := true     ;
              ds  := byteSize ;   (* (value is a byte) *)
              access_memory   ;
              a   := mdr          (* and load it in the Accumulator *)
            end;

       sta: begin
              mdr := a        ;   (* Store the Accumulator *)
              mar := opAddr   ;   (* into the Operand's address *)
              rw  := false    ;   (* False means "write" *)
              ds  := byteSize ;   (* (value is a byte) *)
              access_memory
            end;

       cla: begin
              a   := $0000  ;   (* Clear (set to zero) the Accumulator *)
              z   := true   ;   (* set the Status Bits appropriately *)
              n   := false
            end;

       inc: begin
              a   := a + $0001  ;   (* Increment (add 1 to) the Accumulator *)
              z   := (a = $0000);   (* set the Status Bits appropriately *)
              n   := (a >= $8000)
            end;

       add: begin
              mar := opAddr    ;   (* Get the Operand's value from memory *)
              rw  := true      ;
              ds  := byteSize  ;
              access_memory    ;
              a   := a + mdr   ;   (* and add it to the Accumulator *)
              z   := (a = $0000) ; (* set the Status Bits appropriately *)
              n   := (a >= $8000)
            end;

       cp2: begin
              a   := $FFFF - a + $0001 ;(* (2's) Complement the Accumulator *)
              z   := (a = $0000)  ;     (* set the Status Bits appropriately *)
              n   := (a >= $8000)
            end;

       jmp: pc := opAddr  ; (* opAddr is the address of the next
                                   instruction to execute *)

       jz : if z then pc := opAddr ;(* Jump if the Z status bit is true *)

       jn : if n then pc := opAddr ;(* Jump if the N status bit is true *)

       hlt:  h := true  ;   (* set the Halt status bit *)

       dsp: begin
              mar := opAddr   ;   (* Get the Operand's value from memory *)
              rw  := true     ;
              ds  := byteSize ;
              access_memory   ;
              writeln('memory location $',Int2Hex(mar):4,
                              '  contains the value $', Int2Hex(mdr):2)
            end

       else
          writeln('*** ERROR *** Unknown opCode $', Int2Hex(opCode):4,
                       ' at address $', Int2Hex(pc-2):4)
       end

   until h (* continue the Fetch-Execute cycle until Halt bit is set *)
end ;

(***************************************************************************)

procedure identify_myself ;   (**** CHANGE THIS TO DESCRIBE YOURSELF ****)
begin
   clrscr;
   writeln ;
   writeln('CSI 2111 (December,1995)  Project.') ;
   writeln('first and last name, student# 0123456.') ;
   writeln
end ;

(***************************************************************************)

begin  { main program }
  identify_myself ;
  write('Program name: ');
  readln(program_name);
  assign(input_file, program_name) ;
  reset(input_file) ;

  loader     ;
  close(input_file);
  controller ;
  writeln ('End of program execution.');
  readln     ;
end.

