
.386
.model flat

include csi2121.inc

.data
   str db "0123456789"
   count dd 0Ah  ; number of elements

.code

main:
   lea ebx, str 		; initialize
   mov ecx, count

next:

; ex4-8
	mov eax,[ebx]
   inc ebx
   and eax,0CFh  ; = and eax,11001111b = clear bits 4 & 5
   putint eax    ; = to change 30..39 (ascii codes for '0' to '9') to 0..9
   loop next

   or eax,0AAAAAAAAh  ; = or eax,1010...1010b = set bits 1,3,5...31
   and bh,7Eh         ; = and bh,01111110b = clear msb and lsb
   xor ebx,1          ; = invert lsb

; ex4-18
   mov ax,1011001111001010b ; = 0BC3Ah
   SHL AL,2 					 ; AX = 1011 0011 0010 1000b = 0B328h

   mov ax,1011001111001010b
	SAR AH,2 					 ; AX = 1110 1100 1100 1010b = 0ECCAh

   mov ax,1011001111001010b
	ROR AX,4 					 ; AX = 1010 1011 0011 1100b = 0AB3Ch

   mov ax,1011001111001010b
	ROL AX,3 					 ; AX = 1001 1110 0101 0101b = 9E55h

   mov ax,1011001111001010b
	SAL AL,8 					 ; AX = 1011 0011 0000 0000b = 0B300h

   ret

end
