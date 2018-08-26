
Wsint proc
; Writes a 32-bit signed binary integer to standard 
; output. Input parameters: EAX = value, EBX = radix.

     pusha
     cmp   ebx,2
     jae   ws_cont1
     putstr rad_err
     jmp   ws_exit
ws_cont1:
     cmp   ebx,16
     jbe   ws_cont2
     putstr rad_err
     jmp   ws_exit
ws_cont2:
     mov   esi,ebx           ;save radix into SI
     mov   ebx,offset xtable ; translate table
     xor   ecx,ecx           ; clear digit count
     test  eax,80000000h ; is the signed value in AX negative?
     jz    L3            ; no so display positive value
     putch '-'
     neg   eax       ; perform two's complement
L3:  
     xor   edx,edx   ; clear upper half of dividend
     div   esi       ; divide EDX:EAX by the radix
     xchg  eax,edx   ; now: EAX=remainder and EDX=quotient          
     xlat            ; look up ASCII digit             
     push  eax       ; store digit in stack
     xchg  eax,edx   ; swap quotient into AX
     inc   ecx       ; increment digit count
	  or    eax,eax   ; quotient = 0?
     jnz   L3        ; no: divide again

     ; Display digit in stack starting with last entered
L4:
     pop   edx       ; DL = character to be displayed 
     putch edx       ; display char in DL
     loop  L4
ws_exit:
     popa
     ret
xtable   db  '0123456789ABCDEF'      ; translate table
rad_err  db  "Error: radix must be between 2 and 16",0
Wsint endp


