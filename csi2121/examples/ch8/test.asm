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
	?debug	S "test.c"
	?debug	T "test.c"
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
   ;	void testfunc()
   ;	
	push      ebp
	mov       ebp,esp
   ;	
   ;	{
   ;	}
   ;	
@1:
@2:
	pop       ebp
	ret 
_testfunc	endp

_myfunc	proc	near
?live1@32:
   ;	
   ;	void myfunc(void (*func_ptr)())
   ;	
	push      ebp
	mov       ebp,esp
   ;	
   ;	{
   ;	   (*func_ptr)();
   ;	
@3:
	call      dword ptr [ebp+8]
   ;	
   ;	   return;
   ;	
   ;	
   ;	}
   ;	
@5:
@4:
	pop       ebp
	ret 
_myfunc	endp

_main	proc	near
?live1@96:
   ;	
   ;	void main(void)
   ;	
	push      ebp
	mov       ebp,esp
   ;	
   ;	{
   ;	   void (*func_ptr)() = testfunc;
   ;	
@6:
	mov       eax,offset _testfunc
   ;	
   ;	   myfunc(func_ptr);
   ;	
?live1@128: ; EAX = func_ptr
	push      eax
	call      _myfunc
	pop       ecx
   ;	
   ;	}
   ;	
?live1@144: ; 
@7:
	pop       ebp
	ret 
_main	endp

_TEXT	ends
	public	_testfunc
	public	_myfunc
	public	_main
	?debug	D "test.c" 10365 32146
	end
