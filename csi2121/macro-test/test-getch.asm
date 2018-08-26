
.386
.model flat
include csi2121.inc

.data

	char1 dd '?'

.code

main:

	putch char1
	getloop1:
		getch
		cmp ax,0Ah
		jz continue
		putch eax
		loop getloop1
	continue:
		push dx
	getloop2:
		getch
		cmp ax,0Ah
		jz exit
		putch eax
		loop getloop2
	exit:
		pop dx
	ret

end

