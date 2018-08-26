.386
.model flat
include csi2121.inc   

.data

	hello   db	"hello world!",0

.code             

main:

	putstr hello

	prompt
        
	ret

end     
