
.386
.model flat

include csi2121.inc

.code
                                       
main:
;2-35
	xor ebx,ebx
	cmp eax,7FFh
	MOV bl, 0FFh    ;
	inc bl          ;
	MOV bh, 7Fh     ;
   inc bh          ;

;2-36
   mov ax, -5
   neg ax
   mov ax, 8000h
   neg ax

	ret
   
end
