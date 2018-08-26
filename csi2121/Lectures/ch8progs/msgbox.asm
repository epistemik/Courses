
.386 
.model flat

public _main
extrn MessageBoxA:proc

.data 
MsgBoxCaption  db "CSI 2121/2521 demo",0 
MsgBoxText     db "Win32 Assembly is Great!",0 

NULL     equ  0 
MB_OK    equ  0 

.code 
_main:

	push	MB_OK
	push	offset MsgBoxCaption
	push	offset MsgBoxText
	push	NULL
	call	MessageBoxA
	;stack is cleaned by the Win32 procedure

	ret 
    
end
