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

kill:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 62
	mov rdi, [rbp+24]   ; all proc
	mov rsi, [rbp+16] ; SIGKILL
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
	mov rsi, '!!!!!!  '
	push rsi
	mov rsi, 'cess !!!'
	push rsi
	mov rsi, ' the Pro'
	push rsi
	mov rsi, 'Kill all'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,34
	push rdx
	call write

	
	push 2295
	push 9
	call kill
	

	push 1
	call exit









