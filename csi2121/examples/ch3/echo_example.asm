
.386
.model flat

include csi2121.inc

.code

main:

   getch
   cmp eax,-1 ;<ctrl-z> ?
   je exit    ;yes then exit
   putch eax  ;no, print char
   jmp main

exit:
   ret

end

