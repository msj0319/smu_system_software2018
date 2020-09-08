%include "asm_io.inc"
extern calc_sum, for_loop, end_for

	segment	.data
msg01	db 'input number : ',0x00;
sum: 	dd 0	;second parameter sum 4byte

	
	segment	.text
	global 	main
main:	
	enter 0,0
	pusha
	
	mov eax, msg01;
	call print_string;
	call read_int;
	push dword sum;		push second parameter 
	push dword eax;		push first parameter 
	
	call calc_sum

	;end calc_sum
	add esp,8;		delete parameter
	mov eax,dword[sum];	sum value print
	call print_int
	call print_nl

	mov eax,1
   	mov ebx,0
   	int 0x80

