
.386
.model flat

include csi2121.inc

.code

main:                                                           ;      EIP
                                                                ;    --------
	MOV ax, 8000h   ;                                                 00401108
	MOV bx, 0FFFFh  ;                                                 0040110C
	ADD AX,BX	    ; when AX contains 8000h and BX contains FFFFh.   00401110
                   ; AX = 7FFFh , CF = 1 ; OF = 1
	MOV al, 00h     ;                                                 00401113
	MOV bl, 80h  	 ;                                                 00401115
	SUB AL,BL    	 ; when AL contains 00h and BL contains 80h.       00401117
                	 ; AL = 80h , CF = 1 , OF = 1
	MOV ah, 2Fh  	 ;                                                 00401119
	MOV bh, 52h  	 ;                                                 0040111B
	ADD AH,BH    	 ; when AH contains 2Fh and BH contains 52h.       0040112D
                	 ; AH = 81h , CF = 0 , OF = 1
	MOV ax, 0001h   ;                                                 0040111F
	MOV bx, 0FFFFh  ;                                                 00401123
	SUB AX,BX       ; when AX contains 0001h and BX contains FFFFh    00401127
                   ; AX = 0002h , CF = 1 , OF = 0
	ret                                                               0040112A

end

