
.386
.model flat
include csi2121.inc

.code
main:

	MOV ax,07h			; ax = 7
	MOV bx,0FFFEh		; bl = 254
	DIV bl	 			; 7 / 254 = 0 rem 7
							; al = 00 / ah = 07

	MOV ax,07h			; ax = 7
	MOV bx,0FFFEh		; bl = -2
	IDIV bl	 			; 7 / -2 = -3 rem 1
							; al = FD / ah = 01

	MOV ax,00FBh 		; ax = 251
	MOV bx,0CFFh		; bl = 255
	DIV bl	 			; 251 / 255 = 0 rem 251
							; al = 00 / ah = FB

	MOV ax,00FBh 		; ax = 251
	MOV bx,0CFFh		; bl = -1
	IDIV bl	 			; 251 / -1 = -251 rem 0
							; --> OVERFLOW

	ret

end

