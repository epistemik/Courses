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
	?debug	S "fconv.c"
	?debug	T "fconv.c"
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
	add       esp,-16
	push      ebx
	mov       ebx,offset s@
   ;	
   ;	{
   ;	 float A, B, C, D ;
   ;	
   ;	 printf("Enter the value for A:" );
   ;	
?live1@16: ; EBX = &s@
@1:
	push      ebx
	call      _printf
	pop       ecx
   ;	
   ;	 scanf("%f", &A);
   ;	
	lea       eax,dword ptr [ebp-4]
	push      eax
	lea       edx,dword ptr [ebx+23]
	push      edx
	call      _scanf
	add       esp,8
   ;	
   ;	
   ;	 printf("Enter the value for B:" );
   ;	
	lea       ecx,dword ptr [ebx+26]
	push      ecx
	call      _printf
	pop       ecx
   ;	
   ;	 scanf("%f", &B);
   ;	
	lea       eax,dword ptr [ebp-8]
	push      eax
	lea       edx,dword ptr [ebx+49]
	push      edx
	call      _scanf
	add       esp,8
   ;	
   ;	
   ;	 printf("Enter the value for C:" );
   ;	
	lea       ecx,dword ptr [ebx+52]
	push      ecx
	call      _printf
	pop       ecx
   ;	
   ;	 scanf("%f", &C);
   ;	
	lea       eax,dword ptr [ebp-12]
	push      eax
	lea       edx,dword ptr [ebx+75]
	push      edx
	call      _scanf
	add       esp,8
   ;	
   ;	
   ;	 D = A*A + B*B + C*C ;
   ;	
	fld       dword ptr [ebp-4]
	fmul      dword ptr [ebp-4]
	fld       dword ptr [ebp-8]
	fmul      dword ptr [ebp-8]
	faddp      st(1),st
	fld       dword ptr [ebp-12]
	fmul      dword ptr [ebp-12]
	faddp      st(1),st
	fstp      dword ptr [ebp-16]
   ;	
   ;	 printf("%g squared + %g squared + %g squared = %g", A, B, C, D) ;
   ;	
	fld       dword ptr [ebp-16]
	add       esp,-8
	fstp      qword ptr [esp]
	fld       dword ptr [ebp-12]
	add       esp,-8
	fstp      qword ptr [esp]
	fld       dword ptr [ebp-8]
	add       esp,-8
	fstp      qword ptr [esp]
	fld       dword ptr [ebp-4]
	add       esp,-8
	fstp      qword ptr [esp]
	lea       ecx,dword ptr [ebx+78]
	push      ecx
	call      _printf
	add       esp,36
   ;	
   ;	
   ;	 return 0;
   ;	
?live1@144: ; 
	xor       eax,eax
   ;	
   ;	}
   ;	
@3:
@2:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
_main	endp
_TEXT	ends
_DATA	segment dword public use32 'DATA'
s@	label	byte
	;	s@+0:
	db	"Enter the value for A:",0
	;	s@+23:
	db	"%f",0
	;	s@+26:
	db	"Enter the value for B:",0
	;	s@+49:
	db	"%f",0
	;	s@+52:
	db	"Enter the value for C:",0
	;	s@+75:
	db	"%f",0
	;	s@+78:
	db	"%g squared + %g squared + %g squared = %g",0
	align	4
_DATA	ends
_TEXT	segment dword public use32 'CODE'
_TEXT	ends
	public	_main
	extrn	_printf:near
	extrn	_scanf:near
	extrn	__turboFloat:word
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\search.h" 9787 8192
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\stdlib.h" 9787 8192
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\_nfile.h" 9787 8192
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\_null.h" 9787 8192
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\_defs.h" 9787 8192
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\_stddef.h" 9787 8192
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\stdio.h" 9787 8192
	?debug	D "fconv.c" 10353 43064
	end
