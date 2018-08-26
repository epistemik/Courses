.386
.model flat
include csi2121.inc

.data

	one dd 1.0
	pt5 dd 0.5
        m83p7 dd -83.7
        ff04 dd 5504.0
        fpff dd -1024.0
        op75 dd 1.75

.code             

main:

	mov eax,one
	mov eax,pt5
        mov eax,m83p7
        mov eax,ff04
        mov eax,fpff
        mov eax,op75
	
	ret

end     
