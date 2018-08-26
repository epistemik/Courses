
.386
.model flat

include csi2121.inc

.data
	Q label byte
	A dw 1,2
	B dw 6ABCh
	Z EQU 232
	C db 'ABCD'

.code

main:
	mov eax,0FFFFh
	xor ebx,ebx
	xor ecx,ecx
	xor edx,edx
	MOV ah, Q
	MOV ax, A
	MOV ax, A+1
	MOV ax, A+2
	MOV ax, A+3
	MOV bx, B
	MOV cl, C
	MOV ch, C+1
	MOV dl, C+2
	MOV dh, C+3

	ret
   
end
