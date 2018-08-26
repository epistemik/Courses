
.386
.model flat
include csi2121.inc

.data

	hello   db	"hello!",0Ah,0
	int1 dd 1
	char1 dd 'a'

.code

main:

	putstr hello
	push ax
	putstr hello
	pop ax
	putint int1
	push bx
	putint int1
	pop bx
	putch char1
	push cx
	putch char1
	pop cx
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

