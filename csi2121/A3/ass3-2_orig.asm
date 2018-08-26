
.386
.model flat
include csi2121.inc

.data
	start_msg  db  "Please enter a string",0Ah,0h
	pal_msg  db  "This string is a palindrome",0Ah,0Ah,0h
	not_pal_msg  db  "This string is not a palindrome",0Ah,0Ah,0h

.code

main:
	xor ecx,ecx			; clear the loop count
	mov edx,esp       ; store top of stack position
	mov ebp,esp       ; use ebp to access head of string
	putstr start_msg

	start:
		getch 				; get a string from the keyboard
		cmp eax,0Ah			; at EOLN?
		je continue       ; if yes, compare the letters
		call is_alpha     ; test if alphabetic
		jnz start         ; if no, get next char
		push ax           ; else, put char on stack
		inc ecx           ;       increment the char count
		jmp start         ;       and get next char

	continue:
		shr ecx,1      ; div ecx by 2 to get # of loops
		mov esi,esp    ; use esi to access tail of string
		sub ebp,2      ; adjust ebp to point to first char
		jecxz exit     ; exit if no string

	head:
		mov eax,[ebp] 		; put head char in eax
		call is_alpha     ; alphabetic?
		jz tail           ; if yes, test tail char
		sub ebp,2         ; else, adjust pointer
		jmp head 			;       and get the next head char

	tail:
		mov eax,[esi] 		; put last char in eax
		call is_alpha     ; alphabetic?
		jz compare        ; if yes, compare the current head and tail chars
		add esi,2	 		; else, adjust the pointer
		jmp tail 			;       and get next tail char

	no_pal:
		putstr not_pal_msg     ; display 'not palindrome' message

	exit:
		mov esp,edx      ; restore stack pointer
		ret 				  ; return from main

	compare:
		mov eax,[ebp]     ; put head char in eax
		and ax,0FFDFh		; convert to upper
		mov ebx,[esi]     ; put tail char in ebx
		and bx,0FFDFh		; convert to upper
		cmp ax,bx         ; compare head and tail
		jnz no_pal        ; if not equal, display appropriate msg and exit
		sub ebp,2         ; else, adjust
		add esi,2         ;       pointers
		loop head         ;       and get next chars

	putstr pal_msg       ; display 'palindrome' message
	jmp exit             ; then exit


is_alpha:
; from ch.5 of the lecture notes
; sets ZF = 1 if the character in AL is alphabetic.

		push eax 			; saves original
		and  al,11011111b ; clear bit 5
		cmp  al,'A'       ; check 'A'..'Z' range
		jb ia_exit 			; no, then exit with ZF=0
		cmp  al,'Z'
		ja ia_exit 			; no, then exit with ZF=0

		;it is alpha iff we reach this point
		and eax,0 			; this sets ZF=1

ia_exit:
		pop eax 				; restore original
		ret 					; from is_alpha

end

