
	.386
	.model flat
	public	_main
	extrn	_printf:proc	
	.code
_main	proc
   ;	
	push      ebp
	mov       ebp,esp
	push      esi
	;
   ;	   short int a=2, b=3;
   ;	
	mov       ax,2
	mov       dx,3
   ;	
   ;	   int c=4, d=5, z;
   ;	
   ; EAX = a, EDX = b
	mov       ecx,4
	mov       esi,5
   ;	
   ;		
   ;	   z = f1(a, b, c, d);
   ;	
   ; EAX = a, EDX = b, ECX = c, ESI = d
	push      esi
	push      ecx
	push      edx
	push      eax
	call      _f1
	add       esp,16
	;
   ;	   printf("result = %d\n", z);
   ;	
   ; EAX = z
	push      eax
	push      offset s@
	call      _printf
	add       esp,8
   ;	
   ;	   return 0;
   ;	
	xor       eax,eax
   ;	
	pop       esi
	pop       ebp
	ret 
_main	endp

_f1	proc
   ;	
   ;	int f1(short int a, short int b, int c, int d)
   ;	
	push      ebp
	mov       ebp,esp
	push      ebx
	mov       ebx,dword ptr [ebp+12]
	mov       ecx,dword ptr [ebp+8]
   ;	
   ;	   return (a*a + b*b)/(c+d);
   ;	
   ; ECX = a, EBX = b

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
   ;	
	pop       ebx
	pop       ebp
	ret 
_f1	endp

.data
s@	label	byte
	;	s@+0:
	db	"result = %d",10,0
	
	end

