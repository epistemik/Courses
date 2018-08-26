
.386
.model flat
include csi2121.inc

; Mark Sattolo  428500
; CSI 2121
; Assignment 3, ex.3

.data
	first_msg  db  "Please enter 1st string?",0Ah,0h
	second_msg  db  "Please enter 2nd string?",0Ah,0h
	first_prec  db  "The 1st string alphabetically precedes the 2nd.",0Ah,0h
	second_prec  db "The 2nd string alphabetically precedes the 1st.",0Ah,0h
	identical  db  "The two strings are identical.",0Ah,0h
	prec  db  0h

.code

main:
	xor ebx,ebx				; clear ebx for 1st count
	xor ecx,ecx				; clear ecx for 2nd count
	mov edi,esp       	; store top of stack position
	mov ebp,esp       	; use ebp to access 1st string
	putstr first_msg

	first:
		getch 				; get 1st string from the keyboard
		cmp eax,0Ah			; at EOLN?
		je next				;    yes - get 2nd string
		push eax           ; else, put char on stack
		inc ebx           ;       increment the char count
		jmp first         ;       and get next char

	next:
		mov esi,esp         ; use esi to access 2nd string
		putstr second_msg

	second:
		getch 				; get 2nd string from the keyboard
		cmp eax,0Ah			; at EOLN?
		je prep1				;    yes - prepare to compare the letters
		push eax           ; else, put char on stack
		inc ecx           ;       increment the char count
		jmp second        ;       and get next char

	prep1:
		cmp ebx,ecx       ; check for the longer string
		jb length         ; jump if ecx longer
		je prep2          ; start to compare if they are the same length
		mov prec,2        ; string 2 precedes if string 1 is longer
		jmp prep2
	length:
		xchg ebx,ecx      ; shorter char count is in ecx
		mov prec,1        ; string 1 precedes if string 2 is longer
	prep2:
		jecxz ident   		; if no strings were entered
		sub ebp,4 			; adjust ebp to point to char one of 1st string
		sub esi,4 			; adjust esi to point to char one of 2nd string

	compare:
		mov eax,[ebp]     ; put string 1 char in eax
		mov edx,[esi]     ; put string 2 char in edx
		cmp eax,edx         ; compare string chars
		ja two				; if string 1 greater, go to appropriate msg2
		jb one				; if string 2 greater, go to appropriate msg1
		sub ebp,4         ; else, adjust
		sub esi,4         ;       pointers
		loop compare      ;       and compare next chars

	ident:
		cmp prec,1        ; check for precedence based on length if strings were
								; identical to the last char of the shorter string
		je one            ; if string 1 precedes
		ja two            ; if string 2 precedes
		putstr identical  ; else, display 'identical' message
		jmp exit          ;       then exit

	one:
		putstr first_prec    ; display '1st string' message
		jmp exit

	two:
		putstr second_prec   ; display '2nd string' message

	exit:
		mov esp,edi     ; restore stack pointer
		ret 				 ; return from main

end
