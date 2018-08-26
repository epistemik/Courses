
.386
.model flat
include csi2121.inc

.data

	msg1 db "Enter three initials",0h
   msg2 db "They look better on the left margin",0h

.code

main:

	putstr msg1
   getch       ; get the three initials
   putstr msg2
   putch eax   ; first initial
   putch 0Ah   ; new line
   getch       ; get the second initial
   putch eax   ; display it
   putch 0Ah   ; new line
   getch       ; get the third initial
   putch eax   ; display it
   putch 0Ah   ; new line

	ret

end

