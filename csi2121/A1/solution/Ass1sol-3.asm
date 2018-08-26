; Assignment #1

; Programming Exercise 3

.386
.model flat
include csi2121.inc

.data
 msg1   db  "Enter two decimal digits",10,0
 msg2   db  'The sum of '
 char1  db  ?
 msg3   db  ' and '
 char2  db  ?
        msg4   db  ' is ',10,0

.code
main:
 putstr msg1
 getch ;get first char
 mov char1,al ;save it
 getch ;get second char
 mov char2,al ;save it
 putstr msg2
 add al,char1 ;al=char1+char2
 ;addition of ASCII codes gives a
        ;numeric value larger by 30h+30h
 sub al,60h ;convert to integer value
 movzx eax,al
 putint eax
 ret
end
