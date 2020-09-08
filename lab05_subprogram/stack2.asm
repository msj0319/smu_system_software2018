%include "asm_io.inc"

subpr:
	enter 8,0
	sub esp,8	;local variable 8byte space

	mov eax,[ebp+16];
	call print_int	
	call print_nl

	mov eax,[ebp+12];	
	call print_int
	call print_nl

	mov eax,[ebp+8];	
	call print_int
	call print_nl
	
	mov eax,ebp;		
	call print_int
	call print_nl
	
	mov eax,[ebp-4];	
	call print_int
	call print_nl

	mov eax,[ebp-8];	
	call print_int
	call print_nl
	
	leave		; leave stack frame
	ret

	segment	.text
	global 	main

main: 	enter 0,0
	pusha
	
	push dword 3
	push dword 2
	push dword 1

	call subpr;
	add esp,12	;delete parameter
	call print_int
	call print_nl

	popa
	mov	eax, 0	; return value
	leave			; leave stack frame
	ret