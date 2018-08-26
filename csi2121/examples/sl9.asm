.386
.model flat
include csi2121.inc   

.data

	

.code             

main:

	mov ax, 0FE02h
	IMUL AH		;AH is a sign extension of AL. CF/OF = 0
	mov al, 83h
        mov bh, 10h
	MUL BH		;AH is not 0. So CF/OF = 1
        mov al, 9Dh
	IMUL BH		;AH is not a sign extension of AL, so CF/OF = 1
        mov ax, 0ffh
	IMUL AX,0FFh	;0ff is expanded to fit a word, so it's value is 255, not -1
			;Since AH is not a sign extension of AL, CF/OF = 1
	ret

end     
