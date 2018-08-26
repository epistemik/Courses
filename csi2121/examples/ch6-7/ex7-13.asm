
.386
.model flat
include csi2121.inc

.data

	a1  dd  1.0
	a2  dd  0.5
	a3  dd  -83.7
	b1  dd  5504.0
	b2  dd  -1024.0
	b3  dd  1.75
	fe	 dd  -0.4

.code

main:

	MOV eax,a1		; eax = 3F800000h

	MOV eax,a2		; eax = 3F000000h

	MOV eax,a3		; eax = C2A76666h

	MOV eax,b1		; eax = 45AC0000h

	MOV eax,b2		; eax = C4800000h

	MOV eax,b3		; eax = 3FE00000h

	MOV eax,fe		; eax = BECCCCCDh < rounding >

	ret

end
