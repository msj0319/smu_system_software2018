%include "asm_io.inc"

	segment	.data
array	dd   3, 1, 5, 7, 2, 8, 4, 9, 6, 10
size	dd   10

loop1:  inc eax    
	sub eax,1    
	mov edx,eax	;edx==0
   	add eax,1    	;eax==1, edx==0
	mov ebx,[array+eax*4] ;ebx has temp 

loop2:  cmp ebx,[array+edx*4]    
	jnb else  		;if temporary element > array element ==> else
   	mov edi,[array+edx*4]
   	mov [array+edx*4+4],edi       
	dec edx
   	cmp edx,0
   	jnb loop2	;edx>0 ->jump loop2

else:       
	mov [array+edx*4+4],ebx	
   	loop loop1        
   	
	mov ecx,10    
	mov edx,-1     

print:  inc edx   
	mov eax,[array+edx*4]    
	call print_int
   	call print_nl    
	loop print 
   	mov eax,[array]
   	call print_int        
	
	mov eax,1
   	mov ebx,0
   	int 0x80
	
	segment	.text
	global 	main

main:	mov eax,0    	;first value
	mov ecx,10  	;array length

	call loop1;
	
	mov eax,1
   	mov ebx,0
   	int 0x80
   

