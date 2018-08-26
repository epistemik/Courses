
.386
.model flat
include csi2121.inc

.code

main:
      mov eax, 0
      getch
      cmp al, 'A'
      jb finish
      cmp al, 'Z'
      ja finish
      putch eax

finish:
		ret

end
