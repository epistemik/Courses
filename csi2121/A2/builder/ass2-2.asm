
.386
.model flat
include csi2121.inc

.data
   greet_msg  db  "Enter a boolean number as a string of at most 128 chars:",0h
   error_msg  db  "Wrong input, now exiting...",0h
   disp_msg   db  "This number in hexadecimal is:",0h
   bit_strng  db  132 dup(3)

.code
main:

; binary input
;=============

   xor ebx,ebx		  ; clear ebx
   mov ecx,80h          ; max 128 chars
   lea edx,bit_strng   ; storage space for the bits
   putstr greet_msg

While_:
      getch          ; get the input string
      cmp eax, 0Ah   ; EOL?
      je Display     ;   if yes then display
      cmp al,'0'     ; check that char is '0'
      jb Err_msg     ;   error if below '0'
      cmp al,'1'     ; or is '1'
      ja Err_msg     ;   error if above '1'
      and al,1       ; convert char to numerical value
      mov [edx],al   ; store in memory
      inc ebx        ; increment loop counter
      inc edx        ; increment memory position
      loop While_
      jmp Display    ; display if have processed 128 chars

Err_msg:
      putstr error_msg   ; print msg if an error in input then exit
      jmp Exit


; hex output
;============

Display:
	lea edx,bit_strng   ; edx set to the location of the input bits
    putstr disp_msg
Pad:
    and ebx,3           ; only want to check bits 0 & 1 of the counter
    mov ecx,ebx         ; set the loop count to the number of extra digits
    jecxz Disp_loop     ; skip if zero, i.e. input digits were a multiple of 4
    xor ebx,ebx         ; clear ebx now as it will store the hex amount
    jmp Sum             ; process the 1,2,or 3 extra bits of the input
	Disp_loop:
	   xor ebx,ebx      ; clear ebx for the next hex digit
	   mov ecx,4	  ; process 4 bits per hex digit
	Sum:
      mov eax,[edx]  ; move the next bit to eax
      and eax,0FFh   ; clear all but al
      cmp al,1       ; if al > 1 then at end of input bits so exit
      ja Exit
      sub ecx,1      ; set ecx so that cl is the proper shift amount
      shl eax,cl		; shift the bit by cl times
		add ebx,eax    ; add to total in ebx
		inc edx        ; increment edx to the position of the next bit
      inc ecx        ; restore ecx to the proper loop count
		loop Sum
   cmp bl,10         ; ebx now contains the sum of 4 bits: check if > 10 or not
   jb Digit          ; jmp if value is 0-9
   add bl,37h        ; otherwise, convert hex A-F to chars 'A' to 'F'
   jmp Disp
   Digit:
   	add bl,30h     ; convert numbers 0-9 to chars '0' to '9'
   Disp:
  		putch ebx      ; display the char
   jmp Disp_loop     ; get the next set of bits

Exit:
      putch 0Ah      ; blank line and exit
      ret

end

