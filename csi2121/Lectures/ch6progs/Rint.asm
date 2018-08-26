
Rint proc
; Reads a signed integer from standard input. 
; The first sequence of dec digits determines the number.
; all other entries are ignored. 
; Input: none. 
; Output: EAX contains the number. 

    push  ebx
    push  ecx
    push  edx
    push  esi
    push  edi
 
    mov   edi,1 ;assume that the number is positive
M1:
    getch    ; char in AL
    cmp AL,'+'
    je M1      ; read next char
    cmp AL,'-'
    jne M2
    mov edi,-1  ;the number is negative
    jmp M1      ; read next char
M2:
    call IsDecDigit ;ZF=1 iff AL contains a dec-digit
    jne M1          ; read a char until a digit is found

; a Dec digit as been entered
; perform signed multiplication 
; of positive numbers
; until a non-Dec-digit is entered

    mov ebx,10     ; ebx is the multiplier
    and eax,0Fh    ; convert to numerical value

; eax holds the product 
; initially EAX = first number entered 

M3:
    push eax   ; save product on stack
    getch
    call IsDecDigit 
    jz M4
    pop eax
    jmp done  ; we are done
M4:
    mov ecx,eax   ; save digit in cl
    and ecx,0Fh   ; convert to numerical value
    pop eax       ; recover the product
    imul ebx      ; EDX:EAX = EAX x 10
    JO A6         ; exit if overflow
    add eax,ecx   ; add to product
    JO A6         ; exit if overflow
    jmp M3
done: 
    imul edi   ; EDX:EAX = EAX * sign
       	       ; no possibility of overflow here
    jmp exit   
A6: 
    putstr overflow_msg
exit: 
    pop   edi
    pop   esi
    pop   edx
    pop   ecx
    pop   ebx
    ret      
overflow_msg  db  'integer overflow',10,0
Rint endp

IsDecDigit proc
; sets ZF = 1 iff the character
; in AL is a decimal digit.       
    cmp  al,'0'       
    jb   B1
    cmp  al,'9'
    ja   B1
    test ax,0  ; set ZF=1 
B1: 
    ret
IsDecDigit endp


