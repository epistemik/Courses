
.386
.model flat

include csi2121.inc

.data
	msg1   db  "Enter a lower case letter: ",0
	msg2   db  'In upper case it is: '
	char   db  ?,0

.code

main:

	putstr msg1
	getch	       ; char in eax and goto next line
	sub al,20h   ; converts to upper case
	mov char,al
	putstr msg2

	ret

end

