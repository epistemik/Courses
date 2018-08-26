
.386
.model flat
include csi2121.inc

.data
	msg DW 'a','b','c','d'  ; 0061h,0062h,0063h,0064h
	;       0   2   4   6      1 0   3 2   5 4   7 6

.code
main:

	PUSH msg      				;ESP = 0FEh              STACK  top = 100h
	MOV ax,[esp]  				; AX = 0061h             -----
	PUSH msg+2    				;ESP = 0FCh              FF 00
	MOV eax,[esp] 				;EAX = 00610062h         FE 61  <- ESP-1
	PUSH dword ptr msg+3		;ESP = 0F8h              FD 00
	LEA eax,msg             ;EAX = 0h        1 0     FC 62  <- ESP-2
	POP word ptr [eax]  	;ESP = 0FAh, msg = 6300     FB 64
	MOV ax,msg 					;EAX = 00006300h         FA 00  <- ESP-4
	POP eax    					;EAX = 00626400h         F9 63
	POP ax	    				;EAX = 00620061h         F8 00  <- ESP-3

	ret

end