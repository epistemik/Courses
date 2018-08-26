
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
	msg2 db "Root2 = ",0
	msg3 db "Both roots are complex numbers",0

.code
main:

; get the variable values from ReadFP

	fldcw fpumask
	putstr greet
	putstr msga
	call ReadFP
	jz exit
	mov A,eax
	putstr msgb
	call ReadFP
	jz exit
	mov B,eax
	putstr msgc
	call ReadFP
	jz exit
	mov C,eax

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
	fsubr  		; B*B-4AC on ST, 2A on ST(1)
	ftst  		; compare 0.0 with ST
	fstsw ax  		; store FPU status word into AX
	test ax,4000h 	; is 0.0 = B2-4AC ? (test C3)
	jnz one_root  	; yes, then there is only 1 root

	; now B2-4AC is either positive or negative
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
	fwait 		; tell the CPU to wait

	jmp disp_results

one_root:
	fld B
	fchs

; -B on ST, ; B2-4AC on ST(1), 2A on ST(2)

	fdiv ST,ST(2) ; root1-2 on ST
	fst root1
	fst root2
	fwait 	; tell the CPU to wait

disp_results:
	putstr msg1
	putfp root1
	putch 10
	putstr msg2
	putfp root2

exit:
	putch 10
	ret				; main

no_roots:
	putstr msg3
	jmp exit

;-------------------------------------------------------

 ReadFP proc
;===========

	 push  ebx
	 push  ecx
	 push  edx
	 push  esi
	 push  edi
	 mov   edi,1		; assume that the number is positive

M1:
	 getch			; char in AL
	 cmp AL,'+'
	 je M2a			; read next char
	 cmp AL,'-'
	 jne M2b
	 mov edi,-1		; the number is negative

M2a:
	 getch
M2b:
	 call IsDecDigit	; ZF=1 iff AL contains a dec-digit
	 jne error_fxn		; read a char until a digit is found

; a Dec digit has been entered
; perform signed multiplication of positive numbers
; until a non-Dec-digit is entered

	 mov ebx,10     ; ebx is the multiplier
	 and eax,0Fh    ; convert to numerical value

; eax holds the product
; initially EAX = first number entered

M3:
	 push eax   ; save product on stack
	 getch
	 cmp al,'.'
	 je M5
	 call IsDecDigit
	 je M4
	 jmp error_fxn

M4:
	 mov ecx,eax   	; save digit in cl
	 and ecx,0Fh   	; convert to numerical value
	 pop eax       	; recover the product
	 imul ebx      	; EDX:EAX = EAX x 10
	 JO over_flow		; exit if overflow
	 add eax,ecx   	; add to product
	 JO over_flow    	; exit if overflow
	 jmp M3

M5:
	 pop eax
	 mov whole,eax
	 fld zero
	 mov edx,1

M6:
	 getch
	 cmp al,10
	 je done
	 call IsDecDigit
	 je M7
	 jmp error_fxn

M7:
	 and eax,0Fh   ; convert to numerical value
	 mov frac,eax
	 fild frac
	 mov ecx,edx

Mdiv:
	 fdiv ten
	 fwait
	 loop Mdiv
	 fadd
	 fwait
	 inc edx
	 jmp M6

done:
	 fild whole
	 fadd
	 fwait
	 mov sign,edi
	 fild sign
	 fmul
	 fstp temp
	 fwait
	 mov eax,temp
	 mov dx,1
	 test dx,1
	 jmp Rexit

over_flow:
			putstr overflow_msg

Rexit:
	 pop   edi
	 pop   esi
	 pop   edx
	 pop   ecx
	 pop   ebx
	 ret			; ReadFP

error_fxn:
			pop eax				; clean up the stack
			putstr error_msg
			test ax,0
			jmp Rexit

ReadFP endp

.data
	zero dd 0.0
	ten dd 10.0
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
; sets ZF = 1 iff the character
; in AL is a decimal digit.
	 cmp  al,'0'
	 jb   B1
	 cmp  al,'9'
	 ja   B1
	 test ax,0  ; set ZF=1
B1:
	 ret
IsDecDigit endp
;----------------------------------

;ass4-1.asm
end
