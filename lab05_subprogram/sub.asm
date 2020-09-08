%include "asm_io.inc"

	segment	.data

	segment	.text
	global calc_sum, for_loop, end_for

calc_sum:
	push ebp
	mov ebp,esp;
	sub esp,8		;make room for local sum and num
				
	
	mov dword[ebp-4], 0;	sum=0;
	mov dword[ebp-8], 0;	num == i
	add dword[ebp+8], 1	;input num

for_loop:
	;mov ebx, [ebp-8];	
	;cmp ebx, [ebp+8];	is i <= n?
	;jnle end_for;		if i <!= n loop escape

	mov ebx,dword[ebp-8];	ebx<-sum	

	add [ebp-4], ebx;	sum+=i
	inc dword[ebp-8];	i++
	mov ebx,dword[ebp-8];	
	cmp ebx,dword[ebp+8];	is i <= n?
	jne for_loop;		if i and n not equal, loop escape

end_for:
	mov ebx, [ebp+12];	ebx = sump
	mov eax, [ebp-4];	eax == sum
	mov [ebx], eax;		*sump = sum
			
	mov esp,ebp
	pop ebp
	ret
