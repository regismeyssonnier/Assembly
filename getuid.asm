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

getuid:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 102  
	xor rdi, rdi   
	xor rsi, rsi
	xor rdx, rdx  
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

getgid:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 104  
	xor rdi, rdi   
	xor rsi, rsi
	xor rdx, rdx  
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
	mov rdi, [rbp+16]   ; 1
	xor rsi, rsi
	xor rdx, rdx  
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret



main:

	push word 0x0A0D
	mov rsi, ':       '
	push rsi
	mov rsi, 'User ID '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,18
	push rdx
	call write

	call getuid

	add rax, 48
	xor rdx,rdx
	add rdx,10

	push word 0x0A0D
	push rax
	push rsp
	push rdx
	call write

;group
	push word 0x0A0D
	mov rsi, ':       '
	push rsi
	mov rsi, 'Group ID'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,18
	push rdx
	call write

	call getgid

	add rax, 48
	xor rdx,rdx
	add rdx,10

	push word 0x0A0D
	push rax
	push rsp
	push rdx
	call write
	

	push 1
	call exit















