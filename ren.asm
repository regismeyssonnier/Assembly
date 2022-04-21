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

rename:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 82   
	mov rdi, [rbp+24]   
	mov rsi, [rbp+16] 
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


	push word 0x0A0D
	mov rsi, 'h :     '
	push rsi
	mov rsi, 'e oldpat'
	push rsi
	mov rsi, 'Enter th'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,26
	push rdx
	call write

	
	xor rsi, rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi ; reserve 64 bytes
	push rsp
	mov r14, [rsp]
	xor rdx,rdx
	add rdx, 64
	push rdx
	call read
	mov byte[r14 + rax - 1], 0

	;push r14
	;mov rdx, rax
	;push rdx
	;call write


	push word 0x0A0D
	mov rsi, 'th :    '
	push rsi
	mov rsi, 'e new pa'
	push rsi
	mov rsi, 'Enter th'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,26
	push rdx
	call write

	xor rsi, rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi ; reserve 64 bytes
	push rsp
	mov r15, [rsp]
	xor rdx,rdx
	add rdx, 64
	push rdx
	call read
	mov byte[r15 + rax - 1], 0

	;push r15
	;mov rdx, rax
	;push rdx
	;call write


	push r14
	push r15
	call rename

	cmp rax, 0
	jne error
	push word 0x0A0D
	mov rsi, 's       '
	push rsi
	mov rsi, 'n Succes'
	push rsi
	mov rsi, 'Operatio'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,26
	push rdx
	call write

	jmp end

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


end:
	call exit







