{ *********************************************
  Sim68k, CSI 2111, November 1999.           
  Please identify yourselves here.           
******************************************** }

{  Skeleton of the simulator for the Sim68k processor  }

program Sim68k (input, output) ;

uses    //Crt, 
		simunit; {  Library containing useful functions/procedures  }

const
	  {  List of OpCode or OpNames to create  }
	  iADD  = 0; 		{  Regular binary integer addition   }
	  iADDQ = 1;  	{  Quick binary integer addition                    }
	  iSUB  = 2;  		{  Regular binary integer subtraction               }
	  iSUBQ = 3;  	{  Quick binary integer subtraction                 }
	  iMULS = 4;  	{  Signed binary multiplication                     }
	  iDIVS = 5;  		{  Signed binary division                           }
	  iNEG  = 6;  		{  Signed binary negation                           }
	  iCLR  = 7;  		{  Clear (set to 0)                                 }
	  iNOT  = 8;  		{  Logical NOT                                      }
	  iAND  = 9;  		{  Logical AND                                      }
	  iOR   = 10; 		{  Logical OR                                       }
	  iEOR  = 11; 		{  Logical EXCLUSIVE-OR                             }
	  iLSL  = 12; 		{  Logical Shift Left                               }
	  iLSR  = 13; 		{  Logical Shift Right                              }
	  iROL  = 14; 		{  Rotate Left                                      }
	  iROR  = 15; 		{  Rotate Right                                     }
	  iCMP  = 16; 		{  Compare (to adjust CVNZH according to D - S)     }
	  iTST  = 17; 		{  Test   (to adjust CVNZH according to D)          }
	  iBRA  = 18; 		{  Unconditional branch to the given address        }
	  iBVS  = 19; 		{  Branch to the given address if overflow          }
	  iBEQ  = 20; 		{  Branch to the given address if equal             }
	  iBCS  = 21; 		{  Branch to the given address if carry             }
	  iBGE  = 22; 		{  Branch to the given address if greater or equal  }
	  iBLE  = 23; 		{  Branch to the given address if less    or equal  }
	  iMOVE = 24; 	{  Regular move                                     }
	  iMOVEQ= 25; 	{  Quick move                                       }
	  iEXG  = 26; 		{  Exchange 2 registers                             }
	  iMOVEA= 27; 	{  Move the given address into A[i]                 }
	  iINP  = 28; 		{  Read from keyboard (input)                       }
	  iDSP  = 29; 		{  Display the name, the source and the contents    }
	  iDSR  = 30; 		{  Display the contents of the Status bits          }
	  iHLT  = 31; 		{  HALT                                             }

{  Types already defined in SimUnit.pas. DO NOT REDEFINE                 
		bit      		= boolean;           				* True = 1, False = 0              
		twobits  	= 0..3;                                                 
		byte     	= $00..$FF;          					* $80...$7F, in 2's CF             
		word     	= $0000..$FFFF;      				* $8000...$7FFF, in 2's CF         
		long 		= $00000000..$FFFFFFFF;		* $80000000..$7FFFFFFF, in 2's CF   }

{  Size of Data to manipulate                                            
		byteSize 	= 0;                                                    
		wordSize = 1;                                      
		longSize 	= 2;                 }

type
	 memorySize = $0000..$1000;  {  Memory  }

var
	 program_name: string;
	 option: char;     {  Option chosen from the menu by the user  }
	 Mnemo: array[0..31] of string;                  {  Mnemonics  }
	 memory: array[memorySize] of byte ;  {  4097 bytes of memory  }

	 {  The CPU's registers  }
	 PC:               word ; 					{  Program Counter        }
	 TMPS, TMPD, TMPR: long ; 		{  Temporary Registers    }
	 OpCode:           word ; 				{  OPCODE of the current instruction  }
	 OpAddr1, OpAddr2: word ; 		{  Operand Addresses      }
	 
	 C:                bit  ; 			{  Status bit Carry       }
	 V:               bit  ;			{  Status bit Overflow    }
	 Z:                bit  ; 			{  Status bit Zero		}
	 N:               bit  ; 			{  Status bit Negative    }
	 H:               bit  ;	 		{  Status bit Halt        }

	 D: array[0..1] of long ; 		{  Data Registers         }
	 A: array[0..1] of word ; 	{  Address Registers      }

	 MAR :	word ;			{  Memory Address Register  }
	 MDR :	long ;			{  Memory Data    Register  }
	 RW : 		bit ;			{  Read/Write Bit : READ = True;  WRITE = False  }
	 DS :    	twobits ;		{  Twobits Data Size :  ByteSize=0, WordSize=1, LongSize=2        }

{ **************************************************************************
                                                                         
 Procedures and functions to help you manipulate instruction formats     
                                                                         
************************************************************************** }

function FormatF1 (OpName : byte) : boolean ;
{  Determines the format of the instruction. F1 = true, F2 = false  }
begin
	{  TO BE COMPLETED!!!  }
end;

procedure MnemoInit;
{    Initializes Mnemo with mnemonic codes corresponding  to    
	each instruction according to OpName (0..31)                      
	Used by the translation procedure to determine the OpCode.    }
begin
   Mnemo[iADD]   := 'ADD';
   Mnemo[iADDQ]  := 'ADDQ';
   Mnemo[iSUB]   := 'SUB';
   Mnemo[iSUBQ]  := 'SUBQ';
   Mnemo[iMULS]  := 'MULS';
   Mnemo[iDIVS]  := 'DIVS';
   Mnemo[iNEG]   := 'NEG';
   Mnemo[iCLR]   := 'CLR';
   Mnemo[iNOT]   := 'NOT';
   Mnemo[iAND]   := 'AND';
   Mnemo[iOR]    := 'OR';
   Mnemo[iEOR]   := 'EOR';
   Mnemo[iLSL]   := 'LSL';
   Mnemo[iLSR]   := 'LSR';
   Mnemo[iROL]   := 'ROL';
   Mnemo[iROR]   := 'ROR';
   Mnemo[iCMP]   := 'CMP';
   Mnemo[iTST]   := 'TST';
   Mnemo[iBRA]   := 'BRA';
   Mnemo[iBVS]   := 'BVS';
   Mnemo[iBEQ]   := 'BEQ';
   Mnemo[iBCS]   := 'BCS';
   Mnemo[iBGE]   := 'BGE';
   Mnemo[iBLE]   := 'BLE';
   Mnemo[iMOVE]  := 'MOVE';
   Mnemo[iMOVEQ] := 'MOVEQ';
   Mnemo[iEXG]   := 'EXG';
   Mnemo[iMOVEA] := 'MOVEA';
   Mnemo[iINP]   := 'INP';
   Mnemo[iDSP]   := 'DSP';
   Mnemo[iDSR]   := 'DSR';
   Mnemo[iHLT]   := 'HLT';
end;

{ **************************************************************************
                                                                         
 Procedure Loader, to load machine language programs in memory.          
                                                                         
************************************************************************** }

procedure Loader(name: string);
{  Read into memory a machine language program contained in a file  }
var address: word;
    first_character, ch: char;
    file_68b:    text;        {  Your program in machine language  }
begin
   assign(file_68b, name);
   reset(file_68b);
   address := $0000;
   while (not eof(file_68b))
   do begin
         read(file_68b, first_character);
         if first_character = '/'   {  Beginning of comment  }
         then repeat                {  Skip the comment  }
				read(file_68b, ch)
			until (ch = first_character) or eoln(file_68b);
         while (not eoln(file_68b))
         do begin
			read(file_68b, Memory[address]);
			address := address + $0001
		  end;
         readln(file_68b)
      end;
   writeln ('Program loaded. ', address,' bytes in memory.');
   close(file_68b);
end;

{ **************************************************************************
                                                                         
 Procedure Access_Memory, for reading and writing from and to memory.    
                                                                         
************************************************************************** }

procedure Access_Memory ;
{ Copies an element (Byte, Word, Long) from memory/CPU to CPU/memory  
   Uses DS (byteSize, wordSize, longSize) and RW (read or write).          
   Verifies if we are trying to access an address outside the range allowed for addressing [$0000..$1000].  }
begin
   if ( (MAR >= $0000) AND (MAR <= $1000) )
   then // Valid Memory Address. 
       if RW
       then begin
			{ TRUE  = Read = copy an element from memory to CPU }
				case DS of
					byteSize:
						MDR := Memory[mar];
					wordSize:
						MDR := Memory[MAR] * $100 + Memory[MAR+1];
					longSize: 
						MDR := ((memory[MAR]   * $1000000) AND $FF000000) OR
								   ((memory[MAR+1] * $10000) AND $00FF0000) OR
								   ((memory[MAR+2] * $100) AND $0000FF00) OR
								   ( memory[MAR+3] AND $000000FF);
				end; // case DS
			end // if RW
       else begin
             { FALSE = Write = copy an element from the CPU to memory }
			if DS = byteSize
			then Memory[MAR] := MDR mod $100     // LSB: 8 last bits 
			else begin
			      if DS = wordSize
			      then begin  { wordSize }
						  Memory[MAR] := (MDR div $100) mod $100;   // MSB: 8 first bits 
						  Memory[MAR+1] := MDR mod $100;			// LSB: 8 last bits 
					    end
			      else begin  { longSize }
						Memory[MAR] := (MDR SHR 24) AND $000000FF;    // MSB: 8 first bits 
						{ ** TO BE COMPLETED!!! ** }
					  end;
				end;
			end // RW else
   else  { Invalid Memory Address. }
      begin
         writeln('*** ERROR *** AccessMemory uses the invalid address $', Word2Hex(MAR));
         writeln('PC Address = ', Word2Hex(PC-2));
         H:=True;  // End of simulation...! 
      end;
end; // proc Access_Memory


{***************************************************************************
                                                                         
 Procedure Controller (simulator) + local procedures and functions       
                                                                         
***************************************************************************}

procedure Controller ;
{  Fetch-Execute Cycle simulated by the simulator  }

var
    OpName : Byte;
    Size   : twobits; 	{  byteSize/wordSize/longSize  }
    NbOper : Byte;	{  Number of necessary operands (P+1)  }
    M1, N1 ,
    M2, N2 ,
    Data   : Byte;

    Sm, Dm, Rm: boolean; {  Most Significant Bits of TMPS, TMPD, and TMPR  }

   procedure Init;
   {  Initialize the simulator (PC and status bits).  }
   begin
	{ ** TO BE COMPLETED!!! ** }
   end;

   procedure FetchOpCode;
   {  Fetch the OpCode from memory  }
   begin
	{ ** TO BE COMPLETED!!! ** }
   end;

   procedure DecodeInstr;
   {  Update the fields (OpName, Size, NbOper, M1, N1, M2, N2, Data) 
	 according to given format.  Uses GetBits.  }
   begin
	{  Fields according to formats available  }
	OpName := GetBits(OpCode, 11, 15);
	{ ** TO BE COMPLETED!!! ** }
   end; // proc DecodeInstr

   procedure FetchOperands;
   {  Fetch the operands, according to their number (NbOper) and  addressing modes (M1 et M2)    }
   begin
      if (NbOper > $0)
      then begin
		{  There are operands  }
            if ( FormatF1(OpName) AND (M1=$3) )
            then begin  {  Fetch the address of first operand (in OpAddr1)  }
				{ ** TO BE COMPLETED!!! ** }
			    end;

            {  Fetch the address of second operand, if F1 and 2 operands.  
			2nd operand of an instruction with format F2 is in OpAddr2  
				 ** TO BE COMPLETED!!! ** }

            {  Check invalid number of operands.  
				 ** TO BE COMPLETED!!! ** }
         end;
   end; // proc FetchOperands


{ ************************************************************************ 
  Since many instructions will make local fetches between temporary registers TMPS,TMPD, & 
  TMPR and the memory or the Dn and An registers, it would be useful to create procedures to 
  transfer the words/bytes between them.  Here are 2 suggestions of procedures to do this.     }

procedure FillTMP(var TmpReg : long ;	//  Register to modify  TMPS, TMPD or TMPR  
			                     OpAddrNo : word ; // Address of operand (OpAddr1 or OpAddr2), for mode 11 
			                     Size : twobits ;		//  Data Size 
			                     ModeAdr ,			//  Required Addressing Mode   
			                     RegNo : byte ) ;	//  Register number for  An & Dn 
			                     
{  Transfer data in the required temporary register  }
begin
      {  Depends on Addressing Mode  }
      case ModeAdr of
         $0: {  Data Register Direct  }
             begin
                TmpReg := D[RegNo];
                if (Size = byteSize)
                then begin
					SetByteL(TmpReg, 1, $00);
					SetWord(TmpReg, true, $0000)
				  end
                else 
				if (Size = wordSize)
				then SetWord(TmpReg, true, $0000);
		 end; // $0

         $1: {  Address Register Direct  }
             begin
			{  TO BE COMPLETED!!!  }
             end;

         $3: {  Relative/Absolute Addressing  
             	We need to access memory, except for branching and MOVEA.  }
             begin
			{  TO BE COMPLETED!!!  }
             end;

         $4: {  Address Register Indirect  
             	We need to access memory.  }
             begin
			{  TO BE COMPLETED!!!  }
             end;

         $6: {  Address Register Indirect with Post-Increment  
			We need to access memory.  }
             begin
			{  TO BE COMPLETED!!!  }
             end;

         $7: {  Address Register Indirect with Pre-Decrement  
			We need to access memory.  }
             begin
			{  TO BE COMPLETED!!!  }
             end;

         else begin
				{  This error should never occur, but just in case...!  }
				write('*** ERROR *** Invalid addressing mode (', ModeAdr);
				writeln(') at address PC = ', Word2Hex(PC-2));
				H := true;
			end
	 end // case 
end;  // proc FillTMP


procedure SetResult( TmpReg : long ;		//  Source Register (TMPD...)   
			                       OpAddrNo : word ; 	//  Operand Address (OpAddr1...)  
			                       Size : twobits ;   	//  Data Size    
			                       ModeAdr ,      	//  Required Addressing Mode   
			                       RegNo : byte ) ;	//  Register Number for An & Dn  

   {  Transfer the contents of temporary register to Register or Memory       }
   begin
      {  Depends on Addressing Mode  }
      case ModeAdr of
         $0: {  Data Register Direct  }
		begin
			case Size of
				byteSize: SetBitsL( D[RegNo] , 0 , 7 , TmpReg );
				wordSize: SetWord( D[RegNo] , false , GetWord(TmpReg, false) ) ;
				longSize: D[RegNo] := TmpReg;
			end; // Size
		end; // $0

         $1: {  Address Register Direct  }
              begin
			{ ** TO BE COMPLETED!!! ** }
              end;

         $3: {  Relative/Absolute Addressing  
			We need to access memory, except for branching and MOVEA.  }
             begin
			{ ** TO BE COMPLETED!!! ** }
             end;

         $4: {  Address Register Indirect: We need to access memory.  }
             begin
			{ ** TO BE COMPLETED!!! ** }
             end;

         $6: {  Address Register Indirect with Post-Increment 
             	 We need to access memory. 
            	 ATTENTION: for some instructions, the address register 
            	 					has already been incremented by FillTMP      
            	 DO NOT increment it a 2nd time here           }
             begin
			{ ** TO BE COMPLETED!!! ** }
             end;

         $7: {  Address Register Indirect with Pre-Decrement 
			 We need to access memory. 
			 ATTENTION: for some instructions, the address register 
								has already been decremented by FillTMP      
			 DO NOT decrement it a 2nd time here           }
             begin
			{ ** TO BE COMPLETED!!! ** }
             end;

         else begin
                 write('*** ERROR *** Invalid Addressing Mode (', ModeAdr);
                 writeln(') at address PC = ', Word2Hex(PC-2));
                 H := true;
              end;
      end; // case 
   end;  // proc SetResult 

function CheckCond(Cond: boolean; Message: string):boolean;
   {  Generic error verification function, with message display.
	If Cond is false, display an error message (including the OpName). 
	The Halt Status bit will also be set to false if there is an Error.  }
   begin
	if Cond
		then CheckCond := True
	else
		begin
		writeln('*** ERROR *** ', Message, ' for ', Mnemo[OpName], ' at address $', Word2Hex(PC-2));
		{  Set the H bit to True  }
		H := True;
		CheckCond := False
		end
   end; // fxn CheckCond

procedure SetZN(TmpNo: long);
   {  Since Status bits Z and N are often set the same way in many instructions. 
   	 A procedure would be useful to do this.         }
   begin
      {  Set Z  }
	{ ** TO BE COMPLETED!!! ** }

      {  Set N  }
      case Size of
		byteSize: N := (GetBits(GetWord(TmpNo, false), 7, 7) = 1);
		{ ** TO BE COMPLETED!!! ** }
      end; // case
   end; // proc SetZN

procedure SetSmDmRm(TSrc, TDest, TRes: long);
   { The calculations to find V and C are more complex but are simplified by the use of Sm, Dm, Rm.
	It would be a good Idea to make a procedure to find these values  }
   begin
	{ ** TO BE COMPLETED!!! ** }
   end; // proc SetSmDmRm

function NOB(Size:twobits):byte;
   {  return the "number of bytes"  }
   begin
      if Size = 2
      then NOB := 4
      	else NOB := Ord(Size)+1;
   end; // proc NOB


   { **********************************************************************
    
    The execution of each instruction is done via its micro-program     
    
   ********************************************************************** }

procedure ExecInstr;
   {  Execute the instruction according to opCode.   
	Use a CASE structure where each case corresponds to an instruction and its micro-program.   }
   var	i : byte ;         {  Counter  }
   		tmpA : word ;

begin
    case OpName of

    iADD:  begin
			{  EXAMPLE micro-program according to step 2.4.1 in section 3 
			   1. Fill TMPS if necessary  }
				FillTMP(TMPS, OpAddr1, Size, M1, N1);
			{  2. Fill TMPD if necessary  }
				FillTMP(TMPD, OpAddr2, Size, M2, N2);
			{  3. Compute TMPR using TMPS and TMPD   }
				TMPR := TMPS + TMPD;
			{  4. Update status bits HZNVC if necessary   }
				SetZN(TMPR);
				SetSmDmRm (TMPS, TMPD, TMPR);
				V := (Sm AND Dm AND NOT(Rm)) OR (NOT(Sm) AND NOT(Dm) AND Rm);
				C := (Sm AND Dm) OR (NOT(Rm) AND Dm) OR (Sm AND NOT(Rm));
			{  5. Store the result in the destination if necessary  }
				SetResult(TMPR, OpAddr2, Size, M2, N2);
			end;

  iADDQ: begin
				FillTMP(TMPD, OpAddr2, Size, M2, N2) ;
				TMPS := $0 ;
				SetByteL(TMPS, 0, Data) ;
			{	Sign extension if W or L ??	}
				TMPR := TMPD + TMPS ;
				SetZN(TMPR) ;
				SetSmDmRm (TMPS, TMPD, TMPR) ;
				V := (Sm and Dm and NOT(Rm)) or (NOT(Sm) and NOT(Dm) and Rm) ;
				C := (Sm and Dm) or (NOT(Rm) and Dm) or (Sm and NOT(Rm)) ;
				SetResult(TMPR, OpAddr2, Size, M2, N2) ;
			end;

  iSUB: begin
			FillTMP(TMPS, OpAddr1, Size, M1, N1) ;
			FillTMP(TMPD, OpAddr2, Size, M2, N2) ;
			TMPR := TMPD - TMPS ;
			SetZN(TMPR) ;
			SetSmDmRm (TMPS, TMPD, TMPR) ;
			V := (NOT(Sm) and Dm and NOT(Rm)) or (Sm and NOT(Dm) and Rm) ;
			C := (Sm and NOT(Dm)) or (Rm and NOT(Dm)) or (Sm and Rm) ;
			SetResult(TMPR, OpAddr2, Size, M2, N2) ;
		end;

  iSUBQ: begin
				FillTMP(TMPD, OpAddr2, Size, M2, N2) ;
				TMPS := $0 ;
				SetByteL(TMPS, 0, Data) ;
			{	Sign extension if W or L ??	}
				TMPR := TMPD - TMPS ;
				SetZN(TMPR) ;
				SetSmDmRm (TMPS, TMPD, TMPR) ;
				V := (NOT(Sm) and Dm and NOT(Rm)) or (Sm and NOT(Dm) and Rm) ;
				C := (Sm and NOT(Dm)) or (Rm and NOT(Dm)) or (Sm and Rm) ;
				SetResult(TMPR, OpAddr2, Size, M2, N2) ;
			end;

  iMULS: begin
			if CheckCond( (Size = 1), 'Invalid Data Size' )
			then begin
				FillTMP(TMPS, OpAddr1, Size, M1, N1) ;
				FillTMP(TMPD, OpAddr2, Size, M2, N2) ;
				TMPR := TMPD * TMPS ;
				SetZN(TMPR) ;
				V := false ;
				C := false ;
				SetResult(TMPR, OpAddr2, Size, M2, N2) ;
				end { if size = 1 }
			end;

  iDIVS: begin
			if CheckCond( (Size = 2), 'Invalid Data Size' )
			then begin
				FillTMP(TMPS, OpAddr1, Size, M1, N1) ;
				if CheckCond( (TMPS <> $0), 'Division by Zero' )
				then begin
					FillTMP(TMPD, OpAddr2, Size, M2, N2) ;
					TMPR := TMPD div GetWord(TMPS, false) ;
					SetWord(TMPR, true, ( TMPD mod GetWord(TMPS, false) )) ;
					SetZN(TMPR) ;
					SetSmDmRm (TMPS, TMPD, TMPR) ;
				{	V := division overflow ?? ;	}
					C := false ;
					SetResult(TMPR, OpAddr2, Size, M2, N2) ;
					end { if div by 0 }
				end { if size = 2 }
		end;

  iNEG: begin
			FillTMP(TMPD, OpAddr1, Size, M1, N1) ;
			TMPR := - TMPD ;
			SetZN(TMPR) ;
			V := false ;
			C := false ;
			SetResult(TMPR, OpAddr1, Size, M1, N1)
		end;

  iCLR: begin
			TMPD := $0 ;
			SetZN(TMPD) ;
			V := false ;
			C := false ;
			SetResult(TMPR, OpAddr1, Size, M1, N1)
		end;

  iNOT:  begin
			FillTMP(TMPD, OpAddr1, Size, M1, N1) ;
			TMPR := not(TMPD) ;
			SetZN(TMPR) ;
			V := false ;
			C := false ;
			SetResult(TMPR, OpAddr1, Size, M1, N1)
           end;

  iAND:  begin
			FillTMP(TMPS, OpAddr1, Size, M1, N1) ;
			FillTMP(TMPD, OpAddr2, Size, M2, N2) ;
			TMPR := TMPD and TMPS ;
			SetZN(TMPR) ;
			V := false ;
			C := false ;
			SetResult(TMPR, OpAddr2, Size, M2, N2)
           end;

  iOR: begin
			FillTMP(TMPS, OpAddr1, Size, M1, N1) ;
			FillTMP(TMPD, OpAddr2, Size, M2, N2) ;
			TMPR := TMPD or TMPS ;
			SetZN(TMPR) ;
			V := false ;
			C := false ;
			SetResult(TMPR, OpAddr2, Size, M2, N2)
		end;

  iEOR: begin
			FillTMP(TMPS, OpAddr1, Size, M1, N1) ;
			FillTMP(TMPD, OpAddr2, Size, M2, N2) ;
			TMPR := TMPD xor TMPS ;
			SetZN(TMPR) ;
			V := false ;
			C := false ;
			SetResult(TMPR, OpAddr2, Size, M2, N2)
		end;

  iLSL:  begin
			FillTMP(TMPD, OpAddr2, Size, M2, N2);
			TMPR := TMPD SHL Data;
			SetZN(TMPR);
			V := False;
			if Data > 0 then
				if GetBitsL(TMPD, NOB(Size)*8-Data, NOB(Size)*8-Data) = 1
					then C:=True
					else C:=False
			else C := False;
			SetResult(TMPR, OpAddr2, Size, M2, N2);
			end;

  iLSR: begin
			FillTMP(TMPD, OpAddr2, Size, M2, N2) ;
			TMPR := TMPD shr Data ;
			SetZN(TMPR) ;
			V := false ;
			if Data > 0 then
				C := ( GetBitsL(TMPD, Data-1, Data-1) = 1 )
				else C := false ;
			SetResult(TMPR, OpAddr2, Size, M2, N2)
		end;

  iROL: begin
			FillTMP(TMPD, OpAddr2, Size, M2, N2) ;
			Data := Data mod 32 ;
			TMPR := TMPD shl Data ;
			TMPS := TMPD shr 32-Data ;
			SetBitsL( TMPR, 0, Data-1, TMPS ) ;
			SetZN(TMPR) ;
			V := false ;
			if Data > 0 then
				C := ( GetBitsL(TMPD, NOB(Size)*8-Data, NOB(Size)*8-Data) = 1 )
				else C := false;
			SetResult(TMPR, OpAddr2, Size, M2, N2)
		end;

  iROR: begin
			FillTMP(TMPD, OpAddr2, Size, M2, N2) ;
			Data := Data mod 32 ;
			TMPR := TMPD shr Data ;
			SetBitsL( TMPR, 32-Data, 31, TMPD ) ;
			SetZN(TMPR) ;
			V := false ;
			if Data > 0 then
				C := ( GetBitsL(TMPD, Data-1, Data-1) = 1 )
				else C := false ;
			SetResult(TMPR, OpAddr2, Size, M2, N2)
		end;

  iCMP: begin
			FillTMP(TMPS, OpAddr1, Size, M1, N1) ;
			FillTMP(TMPD, OpAddr2, Size, M2, N2) ;
			TMPR := TMPD - TMPS ;
			SetZN(TMPR) ;
			SetSmDmRm (TMPS, TMPD, TMPR) ;
			V := ( NOT(Sm) and Dm and NOT(Rm) ) or ( Sm and NOT(Dm) and Rm ) ;
			C := ( Sm and NOT(Dm) ) or ( Rm and NOT(Dm) ) or ( Sm and Rm ) ;
		end;

  iTST: begin
			FillTMP(TMPD, OpAddr1, Size, M1, N1) ;
			SetZN(TMPD) ;
			V := false ;
			C := false ;
		end;

  iBRA: begin
			if CheckCond( (M1 = $3), 'Invalid Addressing Mode')
			then
				if CheckCond ( (Size = wordSize), 'Invalid Data Size')
				then
					PC := OpAddr1
		end;

  iBVS: begin
			if CheckCond( (M1 = $3), 'Invalid Addressing Mode')
			then
				if CheckCond ( (Size = wordSize), 'Invalid Data Size')
				then
					if V then 	PC := OpAddr1
		end;

  iBEQ: begin
			if CheckCond( (M1 = $3), 'Invalid Addressing Mode')
			then
				if CheckCond ( (Size = wordSize), 'Invalid Data Size')
				then
					if Z then PC := OpAddr1
		end;

  iBCS: begin
			if CheckCond( (M1 = $3), 'Invalid Addressing Mode')
			then
				if CheckCond ( (Size = wordSize), 'Invalid Data Size')
				then
					if C then PC := OpAddr1
		end;

  iBGE: begin
			if CheckCond( (M1 = $3), 'Invalid Addressing Mode')
			then
				if CheckCond ( (Size = wordSize), 'Invalid Data Size')
				then
					if not( N xor V ) then PC := OpAddr1
		end;

  iBLE: begin
			if CheckCond( (M1 = $3), 'Invalid Addressing Mode')
			then
				if CheckCond ( (Size = wordSize), 'Invalid Data Size')
				then
					if ( N xor V ) then PC := OpAddr1
		end;

  iMOVE: begin
				FillTMP(TMPS, OpAddr1, Size, M1, N1) ;
				SetResult(TMPS, OpAddr2, Size, M2, N2) ;
			end;

  iMOVEQ :  begin
					FillTMP(TMPD, OpAddr2, Size, M2, N2) ;
					SetByteL(TMPD, 0, Data) ;
				{	Sign extension if W or L ??	}
					SetZN(TMPD) ;
					V := false ;
					C := false ;
					SetResult(TMPD, OpAddr2, Size, M2, N2);
				end;

  iEXG: begin
			if CheckCond( ( ( M1 = ($0 OR $1) ) AND ( M2 = ($0 OR $1) ) ), 'Invalid Addressing Mode')
				then begin
				FillTMP(TMPS, OpAddr1, Size, M1, N1) ;
				FillTMP(TMPD, OpAddr2, Size, M2, N2) ;
				SetResult(TMPS, OpAddr1, Size, M2, N2) ;
				SetResult(TMPD, OpAddr2, Size, M1, N1) ;
				V := false ;
				C := false ;
				end { if valid address }
		end;

  iMOVEA:  begin
				if CheckCond( (Size = wordSize), 'Invalid Data Size')
				then
					if CheckCond( ((M1 = $3) AND (M2 = $1)), 'Invalid Addressing Mode')
					then
						SetResult(OpAddr1, OpAddr2, Size, M2, N2)
			end;

  iINP:  begin
			write('Enter a value ');
			case Size of
				byteSize: write('(byte) for ');
				wordSize: write('(word) for ');
				longSize: write('(long) for ');
			end; // case Size
			case M1 of
				$0: write('the register D', N1);
				$1: write('the register A', N1);
				$4: write('the memory address $',Word2Hex(A[N1]):4);
				$6: write('the memory address $',Word2Hex(A[N1]):4);
				$7: write('the memory address $',Word2Hex(A[N1]):4);
				$3: write('the memory address $',Word2Hex(OpAddr1));
			end; // case M1
			write(': ');
			readln(TMPD);
			SetZN(TMPD);
			C:=False;
			V:=False;
			SetResult(TMPD, OpAddr1, Size, M1, N1)
			end;

  iDSP:  begin
              FillTMP(TMPS, OpAddr1, Size, M1, N1);
              case M1 of
                 $0: write('[ D', N1,' ]  = $');
                 $1: write('[ A', N1,' ]  = $');
                 $4: write('[$',Word2Hex(A[N1]),'] = $');
                 $6: begin
                 {  NOB(Size) subtracted to compensate post-incrementation  }
                        tmpA := A[N1] - NOB(Size);
                        write('[$',Word2Hex(tmpA),'] = $');
                     end;
                 $7: write('[$',Word2Hex(A[N1]),'] = $');
                 $3: write('[$',Word2Hex(OpAddr1):4,'] = $');
              end;
              case Size of
                 byteSize : writeln(Byte2Hex(TMPS), ' (byte)');
                 wordSize : writeln(Word2Hex(TMPS), ' (word)');
                 longSize : writeln(Long2Hex(TMPS), ' (long)');
              end
           end;

  iDSR:  writeln ('Status Bits: H:', H, ' N:', N, ' Z:', Z, ' V:', V, ' C:', C);

  iHLT:  H := true  ;   {  Set the Halt Status Bit to 1 (stops program)  }

	end; // case 
end; // proc ExecInstr 


begin {  Controller  }
	Init;
	
	repeat
		FetchOpCode;
		DecodeInstr;
		FetchOperands;
		if NOT(H) then
			ExecInstr;
	until H;
	{  Repeat the Fetch-Execute Cycle until the H bit becomes 1.  }
	
	writeln;
	writeln ('End of program Execution.');
end; // proc Controller 


{ ************************************************************************* }

procedure Identification ;
{ *** TO BE MODIFIED ACCORDING TO YOUR NEEDS *** }
begin
//	clrscr;
	writeln('*** Sim68k ***') ;
	writeln ;
	writeln('Project CSI 2111 (November 1999).') ;
	{  Insert your names and student numbers  }
	writeln('FirstName LastName: #StudentNumber');
	writeln('-------------------------------------');
	writeln;
	writeln('Menu:               ');
	writeln('(e)xecute <file.68b>');
	writeln('(q)uit the simulator');
	writeln;
	writeln;
end ;

{ **************************************************************************
                                                                        
  Main program. Menu with 2 options.                                 
                                                                       
************************************************************************** }

begin  { Main program }
	program_name := '';
	option := ' ';
	MnemoInit;
	
	{  Menu  }
	while (option <> 'q') do
		begin
		identification;
		write('Your Option : ');
		readln(option);
		
		case option of
			'e' : begin
				{  Execution on the simulator  }
				write('Name of the 68k binary program (".68b" will be added automatically): ');
				readln(program_name);
				Loader( concat(program_name,'.68b') );
				Controller; {  Start the simulator  }
				end;
			
			'q' : writeln('Bye! and come again');
			
			else
				writeln('Invalid Option. Please enter e or q.');
		end; // case 
		
		writeln;
		writeln('Press <Enter>.');
		readln;
		end; // while
end.
