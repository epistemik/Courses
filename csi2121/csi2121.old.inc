; macros to use for CSI 2121/2521
; professor: Mario Marchand
; I may add other macros in this file 
; as the course proceeds
; last update: March 4, 2000

EXTERN _printf:NEAR
EXTERN _putchar:NEAR
EXTERN _getchar:NEAR
EXTERN _puts:NEAR
EXTERN _kbhit:NEAR

public _main

main equ <_main>
 


prompt	MACRO
LOCAL waiti, msg, over
     push EAX
     push EBX
     push ECX
     push EDX    
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
     push EAX
     push EBX
     push ECX
     push EDX
     push thechar
     call _putchar
     add  ESP, 4
     pop EDX
     pop ECX
     pop EBX
     pop EAX
ENDM

getch   MACRO
     push EBX
     push ECX
     push EDX
     call _getchar ;; character in EAX
     pop EDX
     pop ECX
     pop EBX
ENDM

putstr  MACRO	stringname:REQ
LOCAL stringformat, over
     push EAX
     push EBX
     push ECX
     push EDX
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
LOCAL string, over
     push EAX
     push EBX
     push ECX
     push EDX
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
LOCAL fpform, ov2
     push EAX
     push EBX
     push ECX
     push EDX
	finit 
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
LOCAL dblform, ov3
     push EAX
     push EBX
     push ECX
     push EDX
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
