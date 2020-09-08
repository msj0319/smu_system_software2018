%include "asm_io.inc"

	segment	.data
	;
	; initialized data is put in the data segment here
	;
	
	segment .bss
	data: resb 1
	string resb 32
	
	segment	.text
	global 	main
main: 	
	mov edx,0;
	mov ecx,0;
	mov ebx,0;

repeat:
	call read_char;		input char->al ;eax contain al
	cmp al,0x0a;		if finish press enter
	je exit			;if last char value 0x0a->jump exit 					;label	
				
	sub eax, 48;		ascii code-48 = int value
	mov dword[data],eax;	input value ascii-48->data
	mov eax,ecx;		clear eax;
	
	mov ebx,2;	
	mul ebx;		
	mov ecx,eax;		
	add ecx,dword[data];	
	
	jmp repeat;
	
		
exit:	mov byte[string+edx-1],0; 마지막 개행문자는 null.

	mov eax,ecx;
	call print_int;
	call print_nl;