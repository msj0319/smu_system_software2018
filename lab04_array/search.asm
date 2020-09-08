%include "asm_io.inc"     
	segment   .data     
array:  dd   3, 1, 5, 7, 2, 8, 4, 9, 6, 10 
size:   dd   10      


segment   .text      
global    main
main:      
	mov edx,0    
	call read_int; 
start:       
	cmp eax,[array+(edx*4)]      ;compare value    
	je   exit      ;20    
	inc edx    
	cmp edx,[size]    
	je   nope    
	jmp  start  

exit:    
	mov eax,edx    
	call print_int    
	call print_nl    
	jmp end;

nope:    
	mov eax,-1    
	call print_int    
	call print_nl 

end:	leave;
	ret