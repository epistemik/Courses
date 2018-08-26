
.386
.model flat
include csi2121.inc

.data
msg1 db "Enter an int: ",0
msg2 db "EAX = ",0

.code
main:
	putstr msg1
	call Rint
	putstr msg2
	mov ebx,10
	call Wsint
	ret 			;from main

include Wsint.asm
include Rint.asm

end

