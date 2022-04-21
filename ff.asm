;arg x86_64        rdi   rsi   rdx   r10   r8    r9    -

section	.text
    	global _start

_start:
	jmp main


execve:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	;xor rdi,rdi
	mov rax, 59  ; execve syscall
	mov rdi, [rbp+16]   ; name
	mov rsi, [rbp+24] ; tab
	mov rdx, 0  
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret


main:
	xor rdx, rdx

	push rdx
	mov rsi, 'dev/null'
	push rsi
	mov rsi, '2>&1 >&/'
	push rsi
	mov r13, rsp


	push rdx
	mov rsi, '-esr'
	push rsi
	mov rsi, '/firefox'
	push rsi
	;mov rsi, '/firefox'
	;push rsi
	mov rsi, '/usr/lib'
	push rsi
	;mov rsi, '../../..'
	;push rsi
	mov r14, rsp

	push rdx
	mov rsi, '-c'
	push rsi
	mov r15, rsp

	push rdx
	mov rsi, '/bin/sh'
	push rsi
	mov rdi, rsp

	push rdx ; push null
	;push r13
	push r14
	push r15
	push rdi
	push rsp

	push rdi
	call execve
