;arg x86_64        rdi   rsi   rdx   r10   r8    r9    -

section	.text
    	global _start
_start:
	jmp main


write:
	enter 0, 0
	mov rax, 1   
	mov rdi, 1   
	mov rsi, [rbp+24] 
	mov rdx, [rbp+16]  
	syscall  
	leave
	ret

read:
	enter 0, 0
	mov rax, 0   
	mov rdi, 0   
	mov rsi, [rbp+24] 
	mov rdx, [rbp+16] 
	syscall  
	leave
	ret

open:
	enter 0, 0
	mov rax, 2   
	mov rdi, [rbp+24] ; file desc
	mov rsi, [rbp+16] ; code
	mov rdx, 0  
	syscall  
	leave
	ret

lseek:
	enter 0, 0
	mov rax, 8  
	mov rdi, [rbp+32]   ; file desc
	mov rsi, [rbp+24]   ; offset
	mov rdx, [rbp+16]   ; SEEK_END
	syscall  
	leave
	ret

readlink:
	enter 0, 0
	mov rax, 89
	mov rdi, [rbp+32] 
	mov rsi, [rbp+24] 
	mov rdx, [rbp+16] 
	syscall  
	leave
	ret

get_path:
	enter 0, 0
	
	push word 0x0A0D
	mov rsi, 'me :    '
	push rsi
	mov rsi, 'e pathna'
	push rsi
	mov rsi, 'Enter th'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,26
	push rdx
	call write

	push word 0x0A0D
	sub rsp, 256
	push rsp
	mov rsi, [rsp]
	mov [rbp+16], rsi
	mov rdx, 256
	push rdx
	call read
	mov rbx, [rbp+16]
	mov byte[rbx + rax-1], 0x00
	mov word[rbx + rax], 0x0A0D

	leave
	ret

exit:
	enter 0, 0
	mov rax, 60 
	mov rdi, 1
	syscall  
	leave
	ret


main:

	push word 0x0A0D
	mov rsi, ' :      '
	push rsi
	mov rsi, 'Target  '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,18
	push rdx
	call write

	push r15
	call get_path
	mov r15, [rsp]

	push r15
	add rax, 2
	push rax
	call write	

	push word 0x0A0D
	push rsp
	push 2
	call write

	push r15
	push 2
	call open
	
	push rax
	push 0
	push 2
	call lseek
	mov r13, rax
	
	sub rsp, 2048
	mov r14, rsp 		
	
	push r15 ;path 
	push r14 ;buf
	push r13 ;sz
	call readlink
	cmp rax, -1
	je error

	push r14
	push rax
	call write
	
	push word 0x0A0D
	push rsp
	push 2
	call write
	

	push word 0x0A0D
	mov rsi, ' OK     '
	push rsi
	mov rsi, 'Readlink'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,18
	push rdx
	call write

	
	jmp exit

error:
	push word 0x0A0D
	mov rsi, 'n ERROR '
	push rsi
	mov rsi, 'Operatio'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,18
	push rdx
	call write
	
	jmp exit
















