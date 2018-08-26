
.386
.model flat
include csi2121.inc

.data

	msg1 db "Enter three initials",0h
   msg2 db "They look better on the left margin",0h

.code

main:

	putstr msg1
   getch
   putstr msg2
   putch eax
   putch 0Ah
   getch
   putch eax
   putch 0Ah
   getch
   putch eax
   putch 0Ah

	ret

end

