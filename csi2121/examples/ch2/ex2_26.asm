.386
.model flat

include csi2121.inc

.data

	A dw 1234h, -1
	B dd 55h, 66778899h

.code

main:

;	MOV eax, A    ->  type mismatch
	MOV bx, A+1   ;  bx = 0FF12h
	MOV bx, A+2   ;  bx = 0FFFFh
	MOV dx, A+4   ;  dx = 0055h
;	MOV cx, B+1   ->  type mismatch
	MOV edx, B+2  ;  edx = 88990000

	ret
   
end
