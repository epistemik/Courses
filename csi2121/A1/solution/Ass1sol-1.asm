
; Assignment #1

; Programming Exercise 1

.386
.model flat
include csi2121.inc

.data
 msg1   db  "Enter three initials",10,0
 msg2   db  'They look better on the left margin',10
        char1  db  ?,10
        char2  db  ?,10
        char3  db  ?,0

.code
main:
 putstr msg1
 getch ;first char in EAX
 mov char1,al ;save it
 getch ;second char in EAX
 mov char2,al ;save it
 getch ;third char in EAX
 mov char3,al ;save it
 putstr msg2
 ret
end
