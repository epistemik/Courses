
	.386p
	model flat
	ifndef	??version
	?debug	macro
	endm
	endif
	?debug	S "cp1.c"
	?debug	T "cp1.c"
_TEXT	segment dword public use32 'CODE'
_TEXT	ends
_DATA	segment dword public use32 'DATA'
_DATA	ends
_BSS	segment dword public use32 'BSS'
_BSS	ends
DGROUP	group	_BSS,_DATA
_DATA	segment dword public use32 'DATA'
	align	4
$ipfkbaia	label	dword
	dd	4
_DATA	ends
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
   ;	   short int a=2, b=3;
   ;	
@1:
	mov       ax,2
	mov       dx,3
   ;	
   ;	   static int c=4;
   ;	   int d=5, z;
   ;	
?live1@32: ; EAX = a, EDX = b
	mov       ecx,5
   ;	
   ;		
   ;	   z = f1(a, b, c, d);
   ;	
?live1@48: ; EAX = a, EDX = b, ECX = d
	push      ecx
	push      dword ptr [$ipfkbaia]
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
	pop       ebp
	ret 
_main	endp
_TEXT	ends
_DATA	segment dword public use32 'DATA'
	align	4
$adgkbaia	label	dword
	dd	5
_DATA	ends
_TEXT	segment dword public use32 'CODE'
_f1	proc	near
?live1@112:
   ;	
   ;	int f1(short int a, short int b, int c, int d)
   ;	
	push      ebp
	mov       ebp,esp
	push      ebx
	push      esi
	mov       ebx,dword ptr [ebp+12]
	mov       ecx,dword ptr [ebp+8]
   ;	
   ;	{
   ;		static int e=5;
   ;		int f=6;
   ;	
?live1@128: ; ECX = a, EBX = b
@4:
	mov       esi,6
   ;	
   ;	   return (a*a + b*b)/(c+d+e+f);
   ;	
?live1@144: ; ECX = a, EBX = b, ESI = f
	movsx     eax,cx
	movsx     edx,cx
	imul      edx
	movsx     ecx,bx
	movsx     edx,bx
	imul      ecx,edx
	add       eax,ecx
	mov       ecx,dword ptr [ebp+16]
	add       ecx,dword ptr [ebp+20]
	add       ecx,dword ptr [$adgkbaia]
	add       esi,ecx
	cdq
	idiv      esi
   ;	
   ;	}
   ;	
?live1@160: ; 
@6:
@5:
	pop       esi
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
	?debug	D "C:\Program Files\Borland\CBuilder3\INCLUDE\_nfile.h" 9289 6144
	?debug	D "C:\Program Files\Borland\CBuilder3\INCLUDE\_null.h" 9289 6144
	?debug	D "C:\Program Files\Borland\CBuilder3\INCLUDE\_defs.h" 9289 6144
	?debug	D "C:\Program Files\Borland\CBuilder3\INCLUDE\_stddef.h" 9289 6144
	?debug	D "C:\Program Files\Borland\CBuilder3\INCLUDE\stdio.h" 9289 6144
	?debug	D "cp1.c" 9850 22081
	end

