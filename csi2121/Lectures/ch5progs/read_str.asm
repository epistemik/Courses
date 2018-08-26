
.386
.model flat
include csi2121.inc

.data
	buffer db 256 dup(0) ;holds input string
	msg_count db " characters have been saved into the buffer",0
	msg_buf db "Here is the buffer content:",0

.code

main:
	lea esi,buffer
	call readstr 		;ebx = char count
	putint ebx
	putstr msg_count
	putstr msg_buf
	putstr buffer
	ret 					;from main


readstr proc
; prompts the user to enter a string
; reads input string and stores it in buffer
; input: esi holds address of buffer
; output: ebx = number of char copied into buffer

	push esi 			;save original
	push eax 			;save original

	xor ebx,ebx
	putstr rs_msg 		;prompt the user

rs_next:
	getch 				;char in eax
	cmp eax,10 			;last char?
	je rs_exit			; yes, then exit
	inc ebx 				;no, inc count
	mov [esi],al 		;copy char into buffer
	inc esi 				;point to next char position
	jmp rs_next

rs_exit:
	pop eax 				;restore original
	pop esi 				;restore original
	ret 					;from readstr

;string used in the proc
rs_msg db "Enter a string?",0

readstr endp

end

