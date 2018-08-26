.386
.model flat
include csi2121.inc   

.data

	A  DW  1234h
	B  LABEL BYTE  ; = 78h
	   DW  5678h
	C  LABEL WORD  ; = BC9Ah
	C1 DB  9Ah
	C2 DB  0BCh

.code

main:

;	MOV AX,B    ; error type mismatch
	MOV AH,B    ; AH = 78h
	MOV CX,C    ; CX = BC9Ah

	MOV BX, WORD PTR B    ; BX = 5678
;	MOV DL, WORD PTR C    ; error type mismatch
	MOV AX, WORD PTR C1   ; AX = BC9Ah

	MOV BX,[C]    ; BX = BC9A  - variable IS just a pointer to a value
	MOV BX,C      ; BX = BC9A  - same

	ret

end     
