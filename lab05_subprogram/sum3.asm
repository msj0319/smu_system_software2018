%include "asm_io.inc"

	segment	.data
	segment .bss
num1:	resd 1
sum:	resd 1
temp:	resd 1
temp2:	resd 1
ten:	resd 1	

	segment	.text
calc_sum:
	enter	8,0		; make room for local sum and num 	
	mov dword[ebp-4],0	; sum == 0
	mov dword[ebp-8],0	; num == i
	add dword[ebp+8],1	; input num

for_loop:
	mov ebx,dword[ebp-8]	;ebx<-sum
	add dword[ebp-4],ebx	;sum+=i
	inc dword[ebp-8]	;i++
	mov ebx,dword[ebp-8]	
	cmp ebx,dword[ebp+8]	;is i <= n?
	jne for_loop		;if i <!= n loop escape
	
	mov ebx,[ebp+12]	;ebx = sump
	mov eax,dword[ebp-4]	;eax == sum
	mov [ebx],eax		;*sump = sum
	mov esp,ebp
	pop ebp
	ret

	global 	main
main:
	enter	0,0		; setup stack frame
	pusha
	mov dword[temp],0
	mov dword[temp2],0
	mov dword[ten],10	
	mov ebx,[ebp+12]
	add ebx,4
	mov eax,[ebx]
	mov ecx,-1
loop2:
	inc ecx			;ascii to integer
	mov eax,[ebx]
	movzx eax, byte [eax+ecx]
	sub eax, 48
	cmp eax,-48
	jz exit			

	mov dword[temp],eax	;decimal digit*10
	mov eax,esi		;temp2=ecx
	mul dword[ten]		;ten = ebx
	mov esi,eax
	add esi,dword[temp]
	jmp loop2
exit:
	mov eax,esi	
	mov dword[num1],eax		
	push dword sum
	push dword dword[num1]
	call calc_sum
	add esp,8		;delete parameter
	mov eax,dword[sum]	;sum value print
	call print_int	
	call print_nl
	
	mov eax,1
   	mov ebx,0
   	int 0x80
	


	
	