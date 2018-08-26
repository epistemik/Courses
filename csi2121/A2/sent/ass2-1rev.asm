
.386
.model flat
include csi2121.inc

; Mark Sattolo  428500
; CSI-2121
; assignment 2, ex.1

.data
	in_string  db  36 dup(17)
	greet_msg  db  "Enter a hex number as a string of at most 32 chars:",10,0
	error_msg  db  "Wrong input, now exiting...",10,0
	disp_msg   db  "This number in binary is:",10,0

.code
main:

; HEX INPUT
;===========

      mov ecx,20h          ; max 32 hex digits
	lea edx,in_string    ; set edx to the memory location for the input digits
	putstr greet_msg

While_:
      getch          ; get input
		cmp eax, 0Ah   ; at EOL?
		  je Display	;   if yes then display
		cmp al,'A'     ; if below 'A' then test if '0' to '9'
		  jb Digit
		cmp al,'F'     ; if above 'F' then an error in input
		  ja Err_msg
		sub al,37h     ; else convert chars 'A' to 'F' to hex A-F

Store:
		mov [edx],al   ; store the hex digit in memory
		inc edx        ; increment the memory position
		loop While_
		jmp Display    ; display if 32 chars have been processed

Digit:
		cmp al,'0'     ; error if below '0'
		  jb Err_msg
		cmp al,'9'     ; error if above '9' as have already tested that below 'A'
		  ja Err_msg
		and al,0CFh    ; else convert chars '0' to '9' to digits 0-9
		jmp Store      ; store the hex digit

Err_msg:
		putstr error_msg   ; print msg and exit if an input error
		jmp Exit


; BINARY OUTPUT
;===============

Display:
	lea edx,in_string   ; set edx to memory location of the hex digits
	putstr disp_msg
	Disp_loop:
		mov eax,[edx]       ; put first digit in eax
		cmp al,15           ; if value > 15 then have processed all input digits
		  ja Exit
		shl eax,28          ; shift the ls 4 bits to the ms 4 bits
		mov ecx,4    		  ; process 4 bits
	Start:
		rol eax,1         ; CF gets msb
		jc One            ; jump if CF = 1
		mov ebx,'0'       ; else set ebx to char '0'
		jmp Disp
	One: mov ebx,'1'     ; set ebx to char '1'
	Disp: putch ebx      ; display the char
	loop Start
	inc edx              ; get the next hex digit
	jmp Disp_loop

Exit:
      putch 0Ah         ; blank line and exit
      ret

end

