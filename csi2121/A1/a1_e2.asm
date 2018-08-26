
.386
.model flat
include csi2121.inc

.data

	msg1 db "Enter a hex digit between A and F",0h
   msg2 db "In decimal it is",0h

.code

main:

	putstr msg1
   getch
	sub eax, 37h
   putstr msg2
   putint eax
	ret

end

