
.386
.model flat
include csi2121.inc

.data
		intro db "Enter two decimal digits",0h
   	final db "The sum of x and y is",0h

.code

main:

	mov ebx, 0          ; initialize ebx to 0
   putstr intro
   getch               ; get the two digits
	mov ebx, eax        ; move the first to ebx
   mov final+11, bl    ; insert it in string 'final'
   sub ebx, 30h        ; convert it from ascii code to its numerical value
   getch               ; get the next digit
   mov final+17, al    ; insert it in string 'final'
   sub eax, 30h        ; convert it from ascii code to its numerical value
   add ebx, eax        ; add the two numbers
   putstr final        ; display string 'final' with the two digits
   putint ebx          ; display the sum
	ret

end

