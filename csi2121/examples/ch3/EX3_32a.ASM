.386
.model flat
include csi2121.inc

.data
		YOU	dw	3421h, 5AC6h
		ME	dd	8AF67B11h

.code

main:

	MOV ESI, OFFSET YOU

	MOV BH, BYTE PTR [ESI+1] ; BH = 34
	MOV BH, BYTE PTR [ESI+2] ; BH = C6

	MOV BX, WORD PTR [ESI+6] ; BX = 8AF6
	MOV BX, WORD PTR [ESI+1] ; BX = C634

	MOV EBX, DWORD PTR [ESI+3] ; EBX = F67B115A

	ret

end
