
.386
.model flat
include csi2121.inc

.data
		intro db "Enter two decimal digits",0h
   	final db "The sum of x and y is",0h

.code

main:

	mov ebx, 0
   putstr intro
   getch
	mov ebx, eax
   mov final+11, bl
   sub ebx, 30h
   getch
   mov final+17, al
   sub eax, 30h
   add ebx, eax
   putstr final
   putint ebx
	ret

end

