
.386
.model flat
include csi2121.inc

; Mark Sattolo  428500
; CSI 2121
; Assignment 3, ex.1

.data

	msg  db	"This file contains ",0h
	words db " words.",0Ah,0h

.code

main:
	xor esi,esi			  ; clear esi to store the # of words
	getch 				    ; get a character from the file
	cmp eax,-1 			  ; at EOF?
	je display       ; if yes, display the # of words
	call is_alpha 		; test if alphabetic
	jnz non_alpha 		; jump if non-alphabetic
	inc esi          ; else increment the word count

	alpha:
		getch 				    ; get next char
		cmp eax,-1 			  ; at EOF?
		je display       ; if yes, go to display
		call is_alpha 		; test if alphabetic
		jnz non_alpha 		; if not, go to non-alpha routine
		jmp alpha        ; otherwise, continue in alpha

	non_alpha:
		getch             ; get next char
		cmp eax,-1        ; at EOF?
		je display        ; if yes, display # of words
		call is_alpha     ; test if alphabetic
		jnz non_alpha     ; if not, continue the non-alpha procedure
		inc esi           ; if alphabetic, increment word count
		jmp alpha         ;    and go to alpha routine

	display:
		putstr msg       ; start display message
		putint esi       ; put # of words
		putstr words     ; finish display

	ret 		; return from main


is_alpha:
; from ch.5 of the course material
; sets ZF = 1 if the character in AL is alphabetic.

		push eax 			      ; saves original
		and  al,11011111b  ; clear bit 5
		cmp  al,'A'        ; check 'A'..'Z' range
		jb ia_exit 			    ; no, then exit with ZF=0
		cmp  al,'Z'
		ja ia_exit 			    ; no, then exit with ZF=0

		;it is alpha iff we reach this point
		and eax,0 			; this sets ZF=1

ia_exit:
		pop eax 			; restore original
		ret 					; from is_alpha

end
