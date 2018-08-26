
.386
.model flat

include csi2121.inc

.data
	aword dw 41h
	adword dd 61h

.code

main:

	putch aword    ; error: 16-bit operand
	putch adword   ; ‘a’ is written on screen
	putch 'b'      ; ’b’ is written on screen
	mov eax, 'c'
	putch eax      ; ’c’ is written on screen
	putch ax       ; error: 16-bit operand

	ret
   
end
