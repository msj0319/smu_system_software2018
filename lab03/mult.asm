%include "asm_io.inc"

	segment	.data
	msg01	db 'Enter a number(A) : ', 0x00;
	msg02	db 'Enter a number(B) : ', 0x00; 
	; initialized data is put in the data segment here
	;
	
	segment .bss
	num1: resd 1
	num2: resd 1	

	segment	.text
	global 	main
main:
	mov eax, msg01;
	call print_string;
	call read_int;
	mov dword[num1],eax;

	mov eax, msg02;
	call print_string;
	call read_int;
	mov dword[num2],eax;
	
	mov eax,dword[num1];
	mov ecx,dword[num2];
	sub ecx,1;
dsd: 	add eax,dword[num1];
	
	loop dsd;
	
		
	call print_int;
	call print_nl;