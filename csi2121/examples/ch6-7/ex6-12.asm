
.386
.model flat
include csi2121.inc

.code
main:

	MOV dx,0h			; dx = 0
	MOV ax,05h			; ax = 5
	MOV bx,0FFFEh		; bx = 65534
	DIV bx	 			; 5 / 65534 = 0 rem 5
							; ax = 0000 / dx = 0005

	MOV dx,0h			; dx = 0
	MOV ax,05h			; ax = 5
	MOV bx,0FFFEh		; bx = -2
	IDIV bx	 			; 5 / -2 = -2 rem 1
							; ax = FFFE / dx = 0001

	MOV dx,0FFFFh		; dx = sign extension
	MOV ax,0FFFBh 		; ax = -5
	MOV bx,2h			; bx = 2
	IDIV bx	 			; -5 / 2 = -2 rem -1
							; ax = FFFE / dx = FFFF

	MOV dx,0FFFFh
	MOV ax,0FFFBh		; dx:ax = 4,294,967,291
	MOV bx,2h			; bx = 2
	DIV bx	 			; dx:ax / 2 = 2,147,483,645 rem 1
							; --> OVERFLOW

	ret

end

