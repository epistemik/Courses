
.386
.model flat

include csi2121.inc

.data
	A DW 1234H
	B LABEL BYTE
  	  DW 5678H
	C LABEL WORD
	C1 DB 9AH
	C2 DB 0BCH

.code

main:

;	MOV AX,B   **Error** ex3app.ASM(19) Operand types do not match
	MOV AH,B   ; AH = 78h
	MOV CX,C   ; CX = 0BC9Ah
	MOV BX, WORD PTR B   ; BX = 5678h
;	MOV DL, WORD PTR C   **Error** ex3app.ASM(23) Operand types do not match
	MOV AX, WORD PTR C1  ; AX = 0BC9Ah
	MOV BX,[C]   ; BX = 0BC9Ah
	MOV BX,C     ; BX = 0BC9Ah

   RET

end
