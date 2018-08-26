
.386
.model flat

include csi2121.inc

.data
	aword dw 243
	adword dd -266

.code

main:

	putint aword    ;error: 16-bit operand
	putint adword   ;-266 is written on screen
	putint -1       ; -1 is written on screen
	mov eax,0FFFFFFFFh
	putint eax      ;-1 is written on screen
	putint ax       ;error: 16-bit operand

	ret

end

