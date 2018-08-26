
.386
.model flat
include csi2121.inc

.data
	msg1 db "Enter a line to be reversed:",0Ah,0h
	msg2 db "Here is your input in reverse:",0Ah,0h

.code

; ch.5, ex.11
main:
	xor ecx,ecx		; sets count to 0
	putstr msg1

read_again:
	getch
	cmp eax,0ah    ; check for EOLN
	je display
	push ax 			; push char 16-bit
	inc ecx 			; inc count
	jmp read_again

display:
	putstr msg2
	jecxz exit

again:
	pop ax	  		; pop char 16-bit
	putch eax
	loop again

exit:
	putch 0Ah
	ret

end

