
.386
.model flat
include csi2121.inc

.data
		msg1 db "Enter two decimal digits",0h
   	msg2 db "The sum of x and y is",0h

.code

main:

	mov ebx, 0
   mov ecx, 0
	putstr msg1
   getch
	mov ebx, eax
   mov msg2+11, bl
   sub ebx, 30h
   getch
   mov ecx, eax
   mov msg2+17, cl
   sub ecx, 30h
   add ecx, ebx
   putstr msg2
   putint ecx
	ret

end

