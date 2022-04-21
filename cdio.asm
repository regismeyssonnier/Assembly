;arg x86_64        rdi   rsi   rdx   r10   r8    r9    -

section	.text
    	global _start

_start:
	xor rbx, rbx
	jmp main

open:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	;xor rdi,rdi
	mov rax, 2   ; open syscall
	mov rdi, [rbp+24]   ; file desc
	mov rsi, [rbp+16] ; code
	mov rdx, 0  
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

close:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	;xor rdi,rdi
	mov rax, 3   ; open syscall
	mov rdi, [rbp+16]   ; file desc
	mov rsi, 0 ; code
	mov rdx, 0  
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

ioctl:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	;xor rdi,rdi
	mov rax, 16  ; ioctl syscall
	mov rdi, [rbp+24]   ; file desc
	mov rsi, [rbp+16] ; code
	mov rdx, 0  
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
	push word 0x0A0D
	mov rsi, '-ROM    '
	push rsi
	mov rsi, 'Eject CD'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,18
	push rdx
	call write
	
	xor rdx, rdx
	push rdx
	mov rsi, '/dev/sr0'
	push rsi
	push rsp
	push 2048
	call open

	push rax
	push 21257
	call ioctl

	pop rax
	pop rax
	push rax
	call close

	xor rdx, rdx
	push rdx
	push word 0x0A0D
	mov rsi, 'Ejected '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,10
	push rdx
	call write

	xor rdx, rdx
	push rdx
	mov rsi, '/bin/sh'
	push rsi
	push rsp
	pop rdi
	
	xor rdx, rdx	
	push rdx ; push null
	push rdi
	push rsp
	;pop rsi

	push rdi
	call execve
		
