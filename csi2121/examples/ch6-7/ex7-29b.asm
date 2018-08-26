
.386
.387
.model flat
include csi2121.inc

.data

	a1  dd  1.1
	a2  dd  1.2
	a3  dd  1.3
	result dd ?

.code
main:
	call Load
	fstp result   		; ST = 1.2, ST(1) = 1.3

	call Load
	fdivr st(2),st		; ST = 1.1, ST(1) = 1.2, ST(3) = 1.1/1.3

	call Load
	fmulp             ; ST = 1.2*1.1, ST(1) = 1.3

	call Load
	fsubrp st(1),st   ; ST = -0.1, ST(1) = 1.3

	call Load
	faddp             ; ST = 2.3, ST(1) = 1.3

	call Load
;	fdivp st,st(1) --> illegal operand
	fdivp st(1),st    ; ST = 1.2/1.1, ST(1) = 1.3

	ret

Load:
	finit
	FLD a3
	FLD a2
	FLD a1
	ret

end
