%include "asm_io.inc"

	segment .data
a	dd   1, 2, 3, 4, 5, 6
rows_a	dd   2
cols_a	dd   3

b	dd   7, 8, 9, 1, 2, 3, 4, 5, 6, 7, 8, 9
rows_b	dd   3
cols_b	dd   4

i  dd   -1 ;i
k  dd   -1 ;k
j  dd   -1 ;j

sum	dd   0
num	dd   0
num2	dd   0
space	dd   ' ';
	

	segment .bss
c	resd  8
rows_c	resd  1
cols_c	resd  1

	segment	.text
	global 	main

main:
	enter	0,0		; setup stack frame
	pusha
	mov eax,0
	mov ebx,0
	mov ecx,0
	mov edx,0
	mov esi,0
	mov edi,0

loop1 :   inc	dword[i]			
	  mov	dword[k],-1
	  mov	eax,dword[i]
	  cmp 	eax,dword[rows_a]
	  je	endloop
	  jne	loop2

loop2 :   inc	dword[k]			
	  mov	eax,dword[k]
	  mov	dword[sum],0
	  mov	dword[j],-1
	  cmp 	eax,dword[cols_b]
	  je	loop1
	  jne	loop3

loop2_1:  mov	esi,dword[k]	
	  mov 	eax,dword[cols_b]	
	  mov	ecx,4
	  mov	ebx,dword[i]	
	  mul	ecx
	  mul	ebx
	  mov	edi,eax
	  mov	eax,dword[sum]
	  mov	[c + (esi*4) + edi],eax		
	  jmp	loop2


loop3 :   inc	dword[j]			
	  mov	eax,[j]
	  cmp	eax,[cols_a]
	  je	loop2_1

	  mov 	eax,dword[cols_a]
	  mov	ecx,4
	  mov	ebx,dword[i]
	  mul	ecx
	  mul	ebx
	  mov	edi,eax
	  mov	esi,dword[j]
	  mov	eax,[a+(esi*4)+edi]
	  mov	dword[num],eax			

	  mov 	esi,dword[k]
	  mov	eax,dword[cols_b]
	  mov	ecx,4
	  mov	ebx,dword[j]
	  mul	ecx
	  mul	ebx
	  mov	edi,eax
	  mov	eax,[b+(esi*4)+edi] 	

	  mov	ebx,dword[num]
	  mul	ebx
	  add	dword[sum],eax			

	  mov	eax,dword[j]
	  cmp	eax,dword[cols_a]
	  jne	loop3

	

endloop:  mov	esi,0
	  mov	eax,dword[rows_a]
	  mov	dword[rows_c],eax
	  mov	eax,dword[cols_b]
	  mov	dword[cols_c],eax	

endloop2: mov	eax,space
	  call	print_string
	  mov	eax,[c+(esi*4)]
	  inc	esi
	  call	print_int
	  cmp	esi,4
	  je	print1
	  jne	endloop2

print1:	  call	print_nl

endloop3: mov	eax,space
	  call	print_string	
	  mov	eax,[c+(esi*4)]
	  inc	esi
	  call	print_int
	  cmp	esi,8
	  je	print2
	  jne	endloop3

print2:	  call	print_nl

	
	  popa
	  mov	eax, 0	; return value
	  leave			; leave stack frame
	  ret

	

	