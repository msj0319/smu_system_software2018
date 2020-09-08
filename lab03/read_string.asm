%include "asm_io.inc"

	segment	.data
	;
	; initialized data is put in the data segment here
	;
	segment .bss	;(마지막 null 문자를 포함한) 입력 문자열의
			; 최대 길이

string 	resb	32
	
	segment	.text
	global 	main
main:	
	mov edx, 0
repeat: call read_char
	mov byte [string+edx],al
	inc edx
	cmp al,0x0a	; 엔터가 눌릴 때까지
	jnz repeat	; 반복 입력
	
	mov byte [string+edx-1],0	; 마지막 개행문자는 null
	mov byte [string+31],0		
	mov eax,string
	call print_string
	call print_nl	