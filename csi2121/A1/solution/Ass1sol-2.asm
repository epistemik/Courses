; Assignment #1

; Programming Exercise 2

.386
.model flat
include csi2121.inc

.data
 msg1   db  "Enter an hex digit between A and F",10,0
 msg2   db  'In decimal it is',10,0

.code
main:
 putstr msg1
 getch ;first char in EAX
 sub eax,37h ;converts to integer value
 putstr msg2
 putint eax
 ret
end
