
.386
.model flat
include csi2121.inc   

.code
main:

	MOV ax,0FFFBh     ; ax = -5
	MOV bx,0FEh			; bl = -2
	IDIV bl	 			; -5 / -2 = 2 rem -1
							; al = 02 / ah = FF

	MOV ax,0080h      ; ax = 128
	MOV bx,0FFh			; bl = -1
	IDIV bl	 			; 128 / -1 = -128 rem 0
							; al = 80 / ah = 00

	MOV ax,7FFFh		; ax = 32,767
	MOV bx,08h			; bl = 8
	DIV bl	 			; 32767 / 8 = 4095 rem 7
							; --> OVERFLOW

	ret

end

