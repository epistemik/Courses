
.386
.model flat

include csi2121.inc

.data

     greet db "Please enter some strings (# to exit): ",10,0

.code

main:
     putstr greet

while_:
        getch
        cmp eax,23h   ; # ?
        je exit       ; yes then exit
        putch eax     ; no, print char
        jmp while_

exit:
     putch 10
     ret

end

