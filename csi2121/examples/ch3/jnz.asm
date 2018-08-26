
.386
.model flat

include csi2121.inc

.code

main:

   mov eax,61h ;char 'a'

again:
   mov ebx,7bh ;one after 'z'
   putch eax
   inc eax
   sub ebx,eax
   jnz again

   ret

end
