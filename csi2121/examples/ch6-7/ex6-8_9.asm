
.386
.model flat
include csi2121.inc   

.code
main:

	MOV eax,1		; 1*(-1)
	IMUL ax,-1		; eax = 0000FFFFh, CF=OF=0
						;		  lsh = ax = -1

	MOV eax,100h 	; 256*256
	IMUL ax,100h 	; eax = 00000000h, CF=OF=1
						;		  lsh = ax = 0

	MOV eax,100h   ; 256*256
	IMUL eax,100h  ; eax = 00010000h, CF=OF=0
						;		  lsh = eax = 65536

	MOV ax,0FE02h  ; al = 2, ah = -2
	IMUL ah 			; 2*(-2) = -4 / ax = FFFCh, CF=OF=0
						;			      lsh = al = -4

	MOV ax,8Eh     ; al = 142
	MOV bx,1000h   ; bh = 16
	MUL bh 			; 142*16 = 2272 / ax = 08E0h, CF=OF=1
						;					  lsh = al = 224

	MOV ax,9Dh     ; al = -99
	MOV bx,1000h   ; bh = 16
	IMUL bh 			; -99*16 = -1584 / ax = F9D0h, CF=OF=1
						;				      lsh = al = -48

	MOV eax,0FFh   ; ax = 255
	IMUL ax,0FFh 	; 255*255 = 65025 / ax = FE01h, CF=OF=1
						;						 lsh = ax = -511
	ret

end

