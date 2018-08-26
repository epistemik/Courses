
.386
.model flat
include csi2121.inc

; Mark Sattolo  428500
; CSI 2121
; Assignment 3, ex.2

.data
	start_msg  db  "Please enter a string?",0Ah,0h
	pal_msg  db  "This string IS a palindrome.",0Ah,0h
	not_pal_msg  db  "This string is NOT a palindrome.",0Ah,0h

.code

main:
	xor ecx,ecx			; clear ecx for loop count
	mov edx,esp       	; store top of stack position
	mov ebp,esp       	; use ebp to access head of string
	putstr start_msg

	start:
		getch 		; get a string from the keyboard
		cmp eax,0Ah		; at EOLN?
		je prep		;    yes - prepare to compare the letters
		call is_alpha     ; test if alphabetic
		jnz start         ; if no, get next char
		and ax,0FFDFh	; else, convert to upper
		push ax           ;       put char on stack
		inc ecx           ;       increment the char count
		jmp start         ;       and get next char

	prep:
		cmp ecx,1    	; if no chars or one char only
		jbe pal  		;    then string is a palindrome
		shr ecx,1  		; else, div ecx by 2 to get # of loops
		mov esi,esp 	; use esi to access tail of string
		sub ebp,2 		; adjust ebp to point to first char

	compare:
		mov eax,[ebp]     ; put head char in eax
		mov ebx,[esi]     ; put tail char in ebx
		cmp ax,bx         ; compare head and tail
		jnz no_pal        ; if not equal, display appropriate msg and exit
		sub ebp,2         ; else, adjust
		add esi,2         ;       pointers
		loop compare      ;       and get next chars to compare

	pal:
		putstr pal_msg    ; display 'palindrome' message
		jmp exit          ; then exit

	no_pal:
		putstr not_pal_msg   ; display 'not palindrome' message

	exit:
		mov esp,edx		; restore stack pointer
		ret 			; return from main


is_alpha:
; from ch.5 of the course material
; sets ZF = 1 if the character in AL is alphabetic.

		push eax 			; saves original
		and  al,11011111b 	; clear bit 5
		cmp  al,'A'       	; check 'A'..'Z' range
		jb ia_exit 			; no, then exit with ZF=0
		cmp  al,'Z'
		ja ia_exit 			; no, then exit with ZF=0

		;it is alpha iff we reach this point
		and eax,0 			; this sets ZF=1

ia_exit:
		pop eax 			; restore original
		ret 				; from is_alpha

end

