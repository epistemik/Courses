
.386
.model flat
include csi2121.inc

.data
	 A dw 10,20,30,40,50,60

.code

main:
	mov ebp, offset A
	mov esi, 2

	mov ax, [ebp+4]	; ax = 30 = 1Eh
	mov bx, 4[ebp]	; bx = 30 = 1Eh

	mov ax, [esi+A]	; ax = 20 = 14h
	mov bx, A[esi]	; bx = 20 = 14h

	mov ax, A[esi+4]	; ax = 40 = 28h
	mov ax, [esi-2+A]	; ax = 10 = 0Ah

; We can also multiply by 2, 4, or 8. Ex:

	mov ax, A[esi*2+2]	; AX = 40 = 28h

	ret

end

