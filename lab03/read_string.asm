%include "asm_io.inc"

	segment	.data
	;
	; initialized data is put in the data segment here
	;
	segment .bss	;(������ null ���ڸ� ������) �Է� ���ڿ���
			; �ִ� ����

string 	resb	32
	
	segment	.text
	global 	main
main:	
	mov edx, 0
repeat: call read_char
	mov byte [string+edx],al
	inc edx
	cmp al,0x0a	; ���Ͱ� ���� ������
	jnz repeat	; �ݺ� �Է�
	
	mov byte [string+edx-1],0	; ������ ���๮�ڴ� null
	mov byte [string+31],0		
	mov eax,string
	call print_string
	call print_nl	