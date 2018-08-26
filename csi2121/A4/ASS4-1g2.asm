
; ass4-1.asm

.386
.387
.model flat
include csi2121.inc

; Mark Sattolo  428500
; CSI 2121
; Assignment 4, ex.1

.data
	fpumask  dw  0000000000111111b
	A dd ?
	B dd ?
	C dd ?
	root1 dd ?
	root2 dd ?
	two dd 2.0
	greet db "Solving Ax^2 + Bx + C = 0",10,0
	msga db "Enter the value of A: ",0
	msgb db "Enter the value of B: ",0
	msgc db "Enter the value of C: ",0
	msg1 db "Root1 = ",0
	msg2 db "Root2 = ",10,0
	msg3 db "Both roots are complex numbers",10,0

.code
main:

; get the variable values from ReadFP

	fldcw fpumask
	putstr greet
	putstr msga
	call ReadFP
	jz exit
	mov A,esi
	putstr msgb
	call ReadFP
	jz exit
	mov B,esi
	putstr msgc
	call ReadFP
	jz exit
	mov C,esi

; FindRoots

	; first form 2*A
	fld A
	fmul two 	; 2*A on ST

	; then form 4AC
	fld ST   	; 2*A on ST, 2*A on ST(1)
	fmul two 	; 4*A on ST, 2*A on ST(1)
	fmul C	 	; 4*A*C on ST, 2*A on ST(1)

	; now form B*B
	fld B
	fmul B		; B*B on ST, 4AC on ST(1), 2A on ST(2)

	; now form B*B - 4AC
	fsubr  			; B*B-4AC on ST, 2A on ST(1)
	ftst  			; compare 0.0 with ST
	fstsw ax  		; store FPU status word into AX
	test ax,4000h 	; is 0.0 = B2-4AC ? (test C3)
	jnz one_root  	; yes, then there is only 1 root

	; now B^2-4AC is either positive or negative
	test ax,100h 	; is 0.0 > B2-4AC ? (test C0)
	jnz no_roots 	; yes, then no real roots

	; here we have two roots
	fsqrt 	; sqrt(B2-4AC) on ST, 2A on ST(1)
	fld ST 	; sqrt on ST and ST(1), 2A on ST(2)
	fchs 		; -sqrt on ST, +sqrt on ST(1), 2A on ST(2)
	fld B
	fchs

; -B on ST, -sqrt on ST(1), +sqrt on ST(2), 2A on ST(3)

	fadd ST(1),ST  	; 2A*root1 on ST(1)
	faddp ST(2),ST 	; 2A*root2 on ST(2) and pop

; 2A*root1 on ST, 2A*root2 on ST(1), and 2A on ST(2)

	fdiv ST,ST(2) 	; root1 on ST
	fstp root1 		; store in memory and pop

;2A*root2 on ST, 2A on ST(1)

	fdiv ST,ST(1)
	fstp root2 		; store in memory and pop
	fwait 			; tell the CPU to wait

	jmp disp_results

one_root:
	fld B
	fchs

; -B on ST, ; B^2-4AC on ST(1), 2A on ST(2)

	fdiv ST,ST(2)	; root1-2 on ST
	fst root1
	fst root2
	fwait				; tell the CPU to wait

disp_results:
	putstr msg1
	putfp root1
	putch 10
	putstr msg2
	putfp root2

exit:
		ret			; from main

no_roots:
	putstr msg3
	jmp exit

;-------------------------------------------------------

 ReadFP proc
;===========

 push  eax        ; save the contents of all the registers that will
 push  ebx        ; be used by ReadFP, except ESI which will return
 push  ecx        ; the number to the caller
 push  edx
 push  edi
 mov edx,1			; default that input is good
 mov edi,1			; default that number is +ve
 mov divsr,1		; reset divisor

M1:
	 getch			; char in AL
	 cmp AL,'+'
	 je M2a			; read next char
	 cmp AL,'-'
	 jne M2b       ; first char is a digit
	 mov edi,-1		; the number is negative

M2a:
	 getch

M2b:
	 call IsDecDigit	; ZF=1 iff AL contains a dec-digit
	 jnz error_fxn		; read a char until a digit is found
	 mov ebx,10     	; ebx is the multiplier
	 and eax,0Fh    	; convert to numerical value

M3:
	 push eax   			; save the current value on the stack
	 getch            	; get next char
	 cmp al,'.'       	; decimal point?
	 je M5            	;    if yes, get the fractional digits
	 call IsDecDigit     ; test if a digit
	 je M4               ;    if yes, continue
	 jmp error_fxn       ;    else, exit with error

M4:
	 mov ecx,eax   	; save current char in ecx
	 and ecx,0Fh   	; convert it to a number
	 pop eax       	; recover the previous digits
	 imul ebx      	; multiply the previous value by 10
	 jo over_flow		; check for overflow
	 add eax,ecx   	; add the current value to the (previous * 10)
	 jo over_flow    	; check for overflow
	 jmp M3           ; or continue the loop

M5:
	 pop eax				; pop the whole part of the number
	 mov whole,eax    ; and store it
	 fld zero         ; initialize the FPU with zero
	 fwait

M6:
	 getch             ; start processing the fractional digits
	 cmp al,10         ; EOL?
	 je done           ;   then done
	 call IsDecDigit   ; test if a digit
	 je M7             ;    if yes, continue
	 jmp error_fxn     ;    else, exit with error

M7:
	 and eax,0Fh			; convert to numerical value
	 mov frac,eax  		; store digit in memory
	 mov eax,divsr			; put current divisor into eax
	 imul eax,10			; multiply by 10
	 jo over_flow			; check for overflow
	 mov divsr,eax			; put back into divisor
	 fild frac        	; load digit on FPU
	 fild divsr				; load the divisor
	 fdiv             	; ST gets frac / divisor
	 fadd                ; ST gets previous digit + current digit
	 fwait
	 jmp M6              ; continue loop

done:
	 mov sign,edi		; move sign to memory
	 fild whole       ; ST = frac part, ST(1) = whole number part
	 fadd             ; ST = frac + whole = number
	 fild sign        ; ST = sign, ST(1) = number
	 fmul             ; ST = +ve or -ve number
	 fstp whole       ; store number in whole
	 fwait
	 mov esi,whole    ; move number to esi for return
	 test dx,1			; ZF = 0 indicates that input was good
	 jmp Rexit

over_flow:
			putstr overflow_msg

Rexit:
	pop edi     ; restore the registers used by ReadFP
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret			; from ReadFP

error_fxn:
			pop eax				; have to clean up the stack if there was an error
			putstr error_msg  ; print the error message
			test dx,0         ; ZF = 1 will signal an input error to the caller
			jmp Rexit

ReadFP endp

.data
	zero dd 0.0
	divsr dd 1
	temp dd ?
	whole dd ?
	sign dd ?
	frac dd ?
	overflow_msg  db  "Integer overflow!",10,0
	error_msg db "Invalid Input",10,0

;-----------------------------------------------

.code
 IsDecDigit proc
;===============
; from ch.6 of the lecture notes
; sets ZF = 1 iff the character in AL is a decimal digit.
	 cmp  al,'0'
	 jb   B1
	 cmp  al,'9'
	 ja   B1
	 test ax,0		; set ZF=1
B1:
	 ret
IsDecDigit endp
;----------------------------------

;ass4-1.asm
end

