
.386
.model flat

include csi2121.inc



.code

main:

     mov ecx, 7Fh

next_:
        putch ecx
        loop next_

exit:
     putch 10
     ret

end

