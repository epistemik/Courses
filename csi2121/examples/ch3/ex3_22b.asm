
.386
.model flat
include csi2121.inc   

.code             

main:
      mov eax, 0
      mov ebx, 0

loop:
      getch
      cmp eax, 0Ah   ;EOL ?
      je exit        ;yes then exit
      inc ebx        ;no, inc counter
      jmp loop

exit:
      putint ebx
      ret

end

