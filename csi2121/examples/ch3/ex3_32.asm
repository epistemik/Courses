
.386
.model flat

include csi2121.inc

.data
	YOU  dw  3421h, 5AC6h
	ME	  dd  8AF67B11h

.code

main:

	mov esi, offset YOU

   MOV BH, BYTE PTR [ESI+1] ; BH =
	MOV BH, BYTE PTR [ESI+2] ; BH =
	MOV BX, WORD PTR [ESI+6] ; BX =
	MOV BX, WORD PTR [ESI+1] ; BX =
	MOV EBX, DWORD PTR [ESI+3] ; EBX =

   RET

end
