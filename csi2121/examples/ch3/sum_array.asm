
.386
.model flat

include csi2121.inc

.data
   arr dd 10,23,45,3,37,66
   count dd 6 		;number of elements

.code

main:

   mov ebx, 0 		;holds the sum
   mov ecx, count
   mov eax, offset arr

next:
   add ebx,[eax]
   add eax,4
   loop next
   putint ebx

   ret

end
