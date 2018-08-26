	.386p
	ifdef ??version
	if    ??version GT 500H
	.mmx
	endif
	endif
	model flat
	ifndef	??version
	?debug	macro
	endm
	endif
	?debug	S "hello.c"
	?debug	T "hello.c"
_TEXT	segment dword public use32 'CODE'
_TEXT	ends
_DATA	segment dword public use32 'DATA'
_DATA	ends
_BSS	segment dword public use32 'BSS'
_BSS	ends
DGROUP	group	_BSS,_DATA
_TEXT	segment dword public use32 'CODE'
_main	proc	near
?live1@0:
   ;	
   ;	int main()
   ;	
	push      ebp
	mov       ebp,esp
   ;	
   ;	{
   ;	
   ;	  printf("hello world!\n");
   ;	
@1:
	push      offset s@
	call      _printf
	pop       ecx
   ;	
   ;	  return 0;
   ;	
	xor       eax,eax
   ;	
   ;	
   ;	}
   ;	
@3:
@2:
	pop       ebp
	ret 
_main	endp
_TEXT	ends
_DATA	segment dword public use32 'DATA'
s@	label	byte
	;	s@+0:
	db	"hello world!",10,0
	align	4
_DATA	ends
_TEXT	segment dword public use32 'CODE'
_TEXT	ends
	public	_main
	extrn	_printf:near
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\_nfile.h" 9787 8192
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\_null.h" 9787 8192
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\_defs.h" 9787 8192
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\_stddef.h" 9787 8192
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\stdio.h" 9787 8192
	?debug	D "hello.c" 10353 20983
	end
