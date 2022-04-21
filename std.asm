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

read:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	xor rdi,rdi
	mov rax, 0   ; use the read syscall
	mov rdi, 0   ; write to stdout
	mov rsi, [rbp+24] ; use string "Hello World"
	mov rdx, [rbp+16]  ; write 12 characters
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
	mov rsi, 'Enter : '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,10
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
	mov byte[r15 + rax-1], 0x0D
	;mov byte[r15 + rax  ], 0x0A
	;mov byte[r15 + rax+1], 0x0
	;mov byte[r15 + rax+2], 0x0

	push r15
	xor rdx,rdx
	add rdx, rax
	;add rdx, 1
	push rdx
	call write
	
	push word 0x0D0D
	mov rsi, '!!!     '
	push rsi
	mov rsi, 'up !!!!!'
	push rsi
	mov rsi, 'Fuck it '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,26
	push rdx
	call write

	push word 0x0A0D
	mov rsi, 'ZZZZr : '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,10
	push rdx
	call write

	

	push 1
	call exit








