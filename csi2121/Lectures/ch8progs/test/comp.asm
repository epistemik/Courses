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
	?debug	S "comp.c"
	?debug	T "comp.c"
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
	push      esi
   ;	
   ;	{
   ;	   short int a=2, b=3;
   ;	
@1:
	mov       ax,2
	mov       dx,3
   ;	
   ;	   int c=4, d=5, z;
   ;	
?live1@32: ; EAX = a, EDX = b
	mov       ecx,4
	mov       esi,5
   ;	
   ;		
   ;	   z = f1(a, b, c, d);
   ;	
?live1@48: ; EAX = a, EDX = b, ECX = c, ESI = d
	push      esi
	push      ecx
	push      edx
	push      eax
	call      _f1
	add       esp,16
   ;	
   ;	   printf("result = %d\n", z);
   ;	
?live1@64: ; EAX = z
	push      eax
	push      offset s@
	call      _printf
	add       esp,8
   ;	
   ;	   return 0;
   ;	
?live1@80: ; 
	xor       eax,eax
   ;	
   ;	}
   ;	
@3:
@2:
	pop       esi
	pop       ebp
	ret 
_main	endp
_f1	proc	near
?live1@112:
   ;	
   ;	int f1(short int a, short int b, int c, int d)
   ;	
	push      ebp
	mov       ebp,esp
	push      ebx
	mov       ebx,dword ptr [ebp+12]
	mov       ecx,dword ptr [ebp+8]
   ;	
   ;	{
   ;	   return (a*a + b*b)/(c+d);
   ;	
?live1@128: ; ECX = a, EBX = b
@4:
	movsx     eax,cx
	movsx     edx,cx
	imul      edx
	movsx     ecx,bx
	movsx     edx,bx
	imul      ecx,edx
	add       eax,ecx
	mov       ecx,dword ptr [ebp+16]
	add       ecx,dword ptr [ebp+20]
	cdq
	idiv      ecx
   ;	
   ;	}
   ;	
?live1@144: ; 
@6:
@5:
	pop       ebx
	pop       ebp
	ret 
_f1	endp
_TEXT	ends
_DATA	segment dword public use32 'DATA'
s@	label	byte
	;	s@+0:
	db	"result = %d",10,0
	align	4
_DATA	ends
_TEXT	segment dword public use32 'CODE'
_TEXT	ends
	public	_main
	public	_f1
	extrn	_printf:near
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\_nfile.h" 9787 8192
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\_null.h" 9787 8192
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\_defs.h" 9787 8192
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\_stddef.h" 9787 8192
	?debug	D "D:\Program Files\Borland\CBuilder4\Include\stdio.h" 9787 8192
	?debug	D "comp.c" 10353 38131
	end
