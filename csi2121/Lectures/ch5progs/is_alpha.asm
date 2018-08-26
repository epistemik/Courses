
.386
.model flat
include csi2121.inc

; This program reads an input string
; and displays it with all non alphabetic
; characters removed

.data
	buffer db 256 dup (0)
	msg1 db "Enter a string?",0
	msg2 db "Here it is with all non-alphabetic chars removed:",0

.code

main:
	lea esi,buffer
	putstr msg1

next:
	getch 				;char in AL
	cmp eax,10 			;last char?
	je display_buf
	call is_alpha 		;test value in AL
	jnz next 			;get next char if not alphabetic
	mov [esi],al 		;save it in buffer
	inc esi 				;point to next char position
	jmp next

display_buf:
	putstr msg2
	putstr buffer
	ret 					;from main


is_alpha:
; sets ZF = 1 if the character
; in AL is alphabetic.

   	push eax 			; saves original
   	and  al,11011111b ; clear bit 5
   	cmp  al,'A'       ; check 'A'..'Z' range
   	jb ia_exit 			;no, then exit with ZF=0
   	cmp  al,'Z'
    	ja ia_exit 			;no, then exit with ZF=0

      ;it is alpha iff we reach this point
   	and eax,0 			;this sets ZF=1

ia_exit:
   	pop eax 				; restore original
		ret 					;from is_alpha

end

