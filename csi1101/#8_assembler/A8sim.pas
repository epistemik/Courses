(***  CSI 1101,  Winter, 1999  ***)
(*** Assignment 8, Simulator program ***)
(*** author: Dr. R. Holte  ***)

program a8sim (input,output) ;

(* the following constants give symbolic names for the opcodes *)

const   LDA = 91 ;   (* Load  Accumulator from memory *)
        STA = 39 ;   (* Store Accumulator into memory *)
        CLA = 08 ;   (* Clear (set to zero)  the Accumulator *)
        INC = 10 ;   (* Increment (add 1 to) the Accumulator *)
        ADD = 99 ;   (* Add to Accumulator *)
        SUB = 61 ;   (* Subtract from Accumulator *)
        JMP = 15 ;   (* Jump ("go to ")  *)
        JZ  = 17 ;   (* Jump if the Zero status bit is TRUE *)
        JN  = 19 ;   (* Jump if the Negative status bit is TRUE *)
        DSP = 01 ;   (* Display (write on the screen) *)
        HLT = 64 ;   (* Halt *)

type byte = -99..99 ;
     word = 0000..9999 ;
     bit  = boolean ;

var memory: array[word] of byte ;
                     (* the following are the registers in the CPU *)
    pc:      word ;  (* program counter *)
    a:       byte ;  (* accumulator     *)
    opCode:  byte ;  (* the opcode of the current instruction *)
    opAddr:  word ;  (* the ADDRESS of the operand of the current instruction *)
    z:       bit  ;  (* "Zero" status bit *)
    n:       bit  ;  (* "Negative" status bit *)
    h:       bit  ;  (* "Halt" status bit     *)

    mar:     word ;  (* Memory Address register *)
    mdr:     byte ;  (* Memory Data    register *)
    rw:      bit  ;  (* Read/Write bit.  Read = True; Write = False *)


procedure load ;(* Loads a machine language program into memory *)
var address: word ;
    first_character, ch: char ;

begin
   address := 0 ;
   while (not eof)
   do begin
         if not eoln
         then begin
                read(first_character);
                if first_character <> ' '   (* non-blank indicates a comment *)
                then repeat                 (* skip over comment *)
                        read(ch)
                     until ch = first_character ;
                while (not eoln)
                do begin
                      read(memory[address]) ;
                      address := address + 1
                   end
              end ;
         readln
      end
end ;

procedure  access_memory ;
begin
   if rw
   then mdr := memory[mar] (* TRUE  = read
                                    = copy a value from memory into the CPU *)
   else memory[mar] := mdr (* FALSE = write
                                    = copy a value into memory from the CPU *)
end ;


procedure run ;   (* This implements the Fetch-Execute cycle *)
begin
   pc := 0 ;      (* always start execution at location 0 *)
   h  := false ;  (* reset the Halt status bit *)
   repeat
   (* FETCH OPCODE *)
       mar := pc     ;
       pc  := pc + 1 ;  (* NOTE that pc is incremented immediately *)
       rw  := true   ;
       access_memory ;
       opCode := mdr ;

   (* If the opcode is odd, it needs an operand.
      FETCH THE ADDRESS OF THE OPERAND *)
       if (opCode mod 2) = 1
       then begin
               mar := pc     ;
               pc  := pc + 1 ;  (* NOTE that pc is incremented immediately *)
               rw  := true   ;
               access_memory ;
               opAddr := mdr ;  (* this is just the HIGH byte of the opAddr *)
               mar := pc     ;
               pc  := pc + 1 ;  (* NOTE that pc is incremented immediately *)
               rw  := true   ;
               access_memory ;  (* this gets the LOW byte *)
               opAddr := 100*opAddr + mdr  (* put the two bytes together *)
            end ;

    (* EXECUTE THE OPERATION *)
       case opCode of

       LDA: begin
              mar := opAddr ;   (* Get the Operand's value from memory *)
              rw  := true   ;
              access_memory ;
              a   := mdr        (* and store it in the Accumulator *)
            end;

       STA: begin
              mdr := a      ;   (* Store the Accumulator *)
              mar := opAddr ;   (* into the Operand's address *)
              rw  := false  ;   (* False means "write" *)
              access_memory  
            end;

       CLA: begin
              a   := 0      ;   (* Clear = set the Accumulator to zero *)
              z   := true   ;   (* set the Status Bits appropriately *)
              n   := false   
            end;

       INC: begin
              a   := (a + 1) mod 100;(* Increment = add 1 to the Accumulator *)
              z   := (a = 0);   (* set the Status Bits appropriately *)
              n   := (a < 0) 
            end;

       ADD: begin
              mar := opAddr ;   (* Get the Operand's value from memory *)
              rw  := true   ;
              access_memory ;
              a   := (a + mdr) mod 100; (* and add it to the Accumulator *)
              z   := (a = 0);   (* set the Status Bits appropriately *)
              n   := (a < 0) 
            end;

       SUB: begin
              mar := opAddr ;   (* Get the Operand's value from memory *)
              rw  := true   ;
              access_memory ;
              a   := (a - mdr) mod 100;(* and subtract it from the Accumulator *)
              z   := (a = 0);   (* set the Status Bits appropriately *)
              n   := (a < 0) 
            end;

       JMP: pc := opAddr  ; (* opAddr is the address of the next
                                   instruction to execute *)

       JZ : if z then pc := opAddr ;(* Jump if the Z status bit is true *)

       JN : if n then pc := opAddr ;(* Jump if the N status bit is true *)

       HLT:  h := true  ;   (* set the Halt status bit *)

       DSP: begin
              mar := opAddr ;   (* Get the Operand's value from memory *)
              rw  := true   ;
              access_memory ;
              writeln('memory location',mar:5,'  contains the value',mdr:3)
            end
       end
   until h (* continue the Fetch-Execute cycle until Halt bit is set *)
end ;


procedure identify_myself ; (*    Writes who you are to the screen *)
begin
   writeln ;
   writeln('CSI 1101 (winter,1999).  Assignment #8, simulator program.') ;
   writeln
end ;

begin (* main program *)
  identify_myself ;
  load ;
  run
end.
