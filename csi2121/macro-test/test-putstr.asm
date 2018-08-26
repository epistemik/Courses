
.386
.model flat
include csi2121.inc

.data

	hello   db	"hello!",0Ah,0

.code

main:

	putstr hello
	push ax
	putstr hello
	pop ax
	putstr hello

	ret

end

