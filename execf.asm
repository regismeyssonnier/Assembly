;arg x86_64        rdi   rsi   rdx   r10   r8    r9    -

section	.text
    	global _start

_start:
	xor rbx, rbx
	jmp main

getpid:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	xor rdi,rdi
	mov rax, 39   ; use the getpid syscall
	;mov rdi, 0   
	;mov rsi, 0 
	;mov rdx, 0  
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

setpriority:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	xor rdi,rdi
	mov rax, 141   ; use the getpid syscall
	mov rdi, [rbp+16]   
	mov rsi, [rbp+24] 
	mov rdx, [rbp+32]  
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret


read:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	xor rdi,rdi
	mov rax, 0   ; use the read syscall
	mov rdi, 1   ; write to stdout
	mov rsi, [rbp+24] ; use string "Hello World"
	mov rdx, [rbp+16]  ; write 12 characters
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret


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
	
main:

	call getpid

	push -20
	push rax
	push 0
	call setpriority
	

	xor rdx, rdx
	push rdx	
	push word 0x0A0D
	mov rsi, 'ile     '
	push rsi
	mov rsi, 'le : ./f'
	push rsi
	mov rsi, 'Run a fi'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,26
	push rdx
	call write

	xor rdx, rdx
	push rdx
	push word 0x0A0D
	mov rsi, 'le :    '
	push rsi
	mov rsi, 'f the fi'
	push rsi
	mov rsi, 'e name o'
	push rsi
	mov rsi, 'Enter th'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,34
	push rdx
	call write

	xor rdx, rdx
	push rdx
	push word 0x0A0D
	xor rsi, rsi
	push rsi
	push rsi
	push rsi
	push rsi ; reserve 32 bytes
	push rsp
	mov r15, [rsp]
	xor rdx,rdx
	add rdx, 32
	push rdx
	call read
	mov r11, rax

	push r15
	xor rdx,rdx
	add rdx, r11
	push rdx
	call write

	
	mov byte[r15 + rax-1], 0
	push r15
	;xchg rsi, r15
	;xor rdx, rdx
	;push rdx
	;xchg rdi, r15
	;push rsi
	;push rsp
	pop rdi

		
	xor rdx, rdx	
	push rdx ; push null
	push rdi
	push rsp
	pop rsi

	push 59  ; execve system call
	pop rax
	syscall
