
	.386
	.model flat

	public	_main
	extrn	_printf:proc

	.code
_main	proc
   ;	
   ;	int main()
   ;	
	push      ebp
	mov       ebp,esp
   ;	
   ;	  printf("hello world!\n");
   ;	
	push      offset s@
	call      _printf
	pop       ecx
   ;	
   ;	  return 0;
   ;	
	xor       eax,eax
   ;	
	pop       ebp
	ret 
_main	endp
 
.data
s@	label	byte
	;	s@+0:
	db	"hello world!",10,0

	end
