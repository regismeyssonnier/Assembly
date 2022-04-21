;arg x86_64        rdi   rsi   rdx   r10   r8    r9    -

section	.text
    	global _start

_start:
	jmp main

reboot:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 169   
	mov rdi, 0xfee1dead   ; MAGIC1
	mov rsi, 672274793 ; 
	mov rdx, [rbp+16]
	mov r15, 'DEADBEEF'
	push r15
	mov r10, rsp
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret



sync:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 162
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

	
	
	call sync
	

	push 1
	call exit









