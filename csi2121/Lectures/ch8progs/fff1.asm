
	.386
	.model flat

	public	_f1

	.code
_f1	proc
   ;	
   ;	int f1(short int a, short int b, int c, int d)
   ;	
   ;	   return (a*a + b*b)/(c+d);
   ;	
	movsx	eax,word ptr [esp+4]
	imul	eax
	movsx	ebx,word ptr [esp+8]
	imul	ebx,ebx
	add	eax,ebx	

	mov       ecx,dword ptr [esp+12]
	add       ecx,dword ptr [esp+16]
	cdq
	idiv      ecx
 
	ret 
_f1	endp
	
	end
