; macros to use for CSI 2121/2521
; professor: Mario Marchand
; I may add other macros in this file 
; as the course proceeds
; last update: March 10, 2000

EXTERN _printf:NEAR
EXTERN _putchar:NEAR
EXTERN _getchar:NEAR
EXTERN _puts:NEAR
EXTERN _kbhit:NEAR

public _main

main equ <_main>
 


prompt	MACRO
LOCAL waiti, waiti2, a1, msg, over
     push EAX
     push EBX
     push ECX
     push EDX 
	test esp,2
	jz a1
	push bx
    	lea   EAX,msg
    	push  EAX
    	call  _puts
    	add   ESP, 4   ;;  clean up stack
waiti2:
     	call  _kbhit
     	cmp   EAX, 0
     	je    waiti2
	pop bx
	jmp over   
a1:
    lea   EAX,msg
    push  EAX
    call  _puts
    add   ESP, 4   ;;  clean up stack
waiti:
     call  _kbhit
     cmp   EAX, 0
     je    waiti
     jmp over
msg db 'Hit a key to continue',0
over:
     pop EDX
     pop ECX
     pop EBX
     pop EAX
ENDM


putch   MACRO  thechar:REQ
LOCAL a1, over
     push EAX
     push EBX
     push ECX
     push EDX
	test esp,2
	jz a1
	push bx
     	push thechar
     	call _putchar
     	add  ESP, 4
	pop bx
	jmp over
a1:
     push thechar
     call _putchar
     add  ESP, 4
over:
     pop EDX
     pop ECX
     pop EBX
     pop EAX
ENDM

getch   MACRO
LOCAL a1, over
     push EBX
     push ECX
     push EDX
	test esp,2
	jz a1
	push bx
	call _getchar
	pop bx
	jmp over
a1:
     call _getchar ;; character in EAX
over:
     pop EDX
     pop ECX
     pop EBX

ENDM

putstr  MACRO	stringname:REQ
LOCAL stringformat, over, a1	
     push EAX
     push EBX
     push ECX
     push EDX
	test esp,2
	jz a1
	push bx
        lea EAX, stringname
        push EAX
        lea EAX, stringformat
        push EAX
        call _printf
        add ESP,8
	pop bx
        jmp over
a1:
     lea EAX, stringname
     push EAX
     lea EAX, stringformat
     push EAX
     call _printf
     add ESP,8
     jmp over
stringformat db '%s', 0
over:
     pop EDX
     pop ECX
     pop EBX
     pop EAX
ENDM

putint	MACRO	theint:REQ
LOCAL string, over, a1
     push EAX
     push EBX
     push ECX
     push EDX
	test esp,2
	jz a1
	push bx
	push	theint
	lea	EAX, string
	push	EAX
	call	_printf
	add	ESP, 8
	pop bx
	jmp over
a1:
	push	theint
	lea	EAX, string
	push	EAX
	call	_printf
	add	ESP, 8
	jmp over
string	db	'%d', 0
over:
     pop EDX
     pop ECX
     pop EBX
     pop EAX
ENDM


putfp	MACRO	thefp:REQ
LOCAL fpform, ov2, a1
     push EAX
     push EBX
     push ECX
     push EDX
	finit 
	test esp,2
	jz a1
	push bx
	fld dword ptr thefp
	sub ESP, 8
	fstp qword ptr [ESP]
	fwait
	lea EAX, fpform
	push EAX
	call _printf
	add ESP, 12
	pop bx	
	jmp ov2
a1:	
	fld dword ptr thefp
	sub ESP, 8
	fstp qword ptr [ESP]
	fwait
	lea EAX, fpform
	push EAX
	call _printf
	add ESP, 12
	jmp ov2
fpform  db	'%.6E', 0  
ov2:
     pop EDX
     pop ECX
     pop EBX
     pop EAX
ENDM

putdbl	MACRO	thedbl:REQ
LOCAL dblform, ov3, a1
     push EAX
     push EBX
     push ECX
     push EDX
	test esp,2
	jz a1
	push bx
	push dword ptr thedbl+4
	push dword ptr thedbl
	lea EAX, dblform
	push EAX
	call _printf
	add ESP, 12
	pop bx
	jmp ov3
a1:	
	push dword ptr thedbl+4
	push dword ptr thedbl
	lea EAX, dblform
	push EAX
	call _printf
	add ESP, 12
	jmp ov3
dblform  db	'%.14E', 0  
ov3:
     pop EDX
     pop ECX
     pop EBX
     pop EAX
ENDM
