;arg x86_64        rdi   rsi   rdx   r10   r8    r9    -

section	.text
    	global _start
_start:
	jmp main

write:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	xor rdi,rdi
	mov rax, 1   ; use the write syscall
	mov rdi, 1   ; write to stdout
	mov rsi, [rbp+24] ; use string "Hello World"
	mov rdx, [rbp+16]  ; write 12 characters
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

creat:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 85
	mov rdi, [rbp+24] 
	mov rsi, [rbp+16]  
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

umask:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 95
	mov rdi, [rbp+16] 
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

iopl:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 172
	mov rdi, [rbp+16] 
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

exit:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	;xor rdi,rdi
	mov rax, 60  ; exit syscall
	mov rdi, 1
	xor rsi, rsi
	xor rdx, rdx  
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

main:

	push 0
	call umask

	xor rsi, rsi
	push rsi
	mov rsi, 'kfi.k'
	push rsi
	push rsp
	push 7777o
	call creat
	
	cmp rax, -1
	je error
	


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

