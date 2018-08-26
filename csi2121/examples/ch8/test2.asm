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
	?debug	S "test2.c"
	?debug	T "test2.c"
_TEXT	segment dword public use32 'CODE'
_TEXT	ends
_DATA	segment dword public use32 'DATA'
_DATA	ends
_BSS	segment dword public use32 'BSS'
_BSS	ends
DGROUP	group	_BSS,_DATA
_TEXT	segment dword public use32 'CODE'

_testfunc	proc	near
?live1@0:
   ;	
   ;	void testfunc(char a, char *b, char *c)
   ;	
	push      ebp
	mov       ebp,esp
   ;	
   ;	{}
   ;	
@1:
@2:
	pop       ebp
	ret 
_testfunc	endp

_main	proc	near
?live1@32:
   ;	
   ;	void main()
   ;	
	push      ebp
	mov       ebp,esp
	push      ecx
   ;	
   ;	{
   ;	  char i=1;
   ;	
@3:
	mov       byte ptr [ebp-1],1
   ;	
   ;	  char *p;
   ;	  p = &i;
   ;	
	lea       eax,dword ptr [ebp-1]
   ;	
   ;	  testfunc(i,&i,p);
   ;	
?live1@80: ; EAX = p
	push      eax
	lea       edx,dword ptr [ebp-1]
	push      edx
	mov       cl,byte ptr [ebp-1]
	push      ecx
	call      _testfunc
	add       esp,12
   ;	
   ;	}
   ;	
?live1@96: ; 
@4:
	pop       ecx
	pop       ebp
	ret 
_main	endp

_TEXT	ends
	public	_testfunc
	public	_main
	?debug	D "test2.c" 10365 32370
	end
