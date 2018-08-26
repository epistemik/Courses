.386
.model flat
include csi2121.inc   

.data

	

.code             

main:

	mov ax, 0fffbh
        mov bl, 0feh
	IDIV BL 	;-5 / -2 = -2 R -1
	mov ax, 0080h
	mov bl, 0ffh
	IDIV BL		;128 / -1 = -128 R 0
	mov ax, 7fffh
	mov bl, 08h
	DIV BL 		;32765 / 8 = 4??? This number is too large to fit in 1 byte,
			;so we have an overflow

	ret

end     
