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

symlink:
	enter 0, 0
	mov rax, 88 
	mov rdi, [rbp+24] 
	mov rsi, [rbp+16] 
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

	push word 0x0A0D
	mov rsi, ' name : '
	push rsi
	mov rsi, 'Sym link'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,18
	push rdx
	call write

	push r14
	call get_path
	mov r14, [rsp]

	push r14
	add rax, 2
	push rax
	call write	

	push word 0x0A0D
	push rsp
	push 2
	call write
	
	push r15 ;target 
	push r14 ;symlink
	call symlink

	cmp rax, -1
	je error

	push word 0x0A0D
	mov rsi, 'OK      '
	push rsi
	mov rsi, 'Symlink '
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
















