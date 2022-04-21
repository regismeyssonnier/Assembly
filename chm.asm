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
	mov rdi, 1   ; write to stdout
	mov rsi, [rbp+24] ; use string "Hello World"
	mov rdx, [rbp+16]  ; write 12 characters
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

chmod:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 90  
	mov rdi, [rbp+16]   
	mov rsi, [rbp+24]
	xor rdx, rdx  
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

get_path:
	enter 0, 0
	
	push word 0x0A0D
	mov rsi, 'me :    '
	push rsi
	mov rsi, 'e pathna'
	push rsi
	mov rsi, 'Enter th'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,26
	push rdx
	call write

	push word 0x0A0D
	sub rsp, 256
	push rsp
	mov rsi, [rsp]
	mov [rbp+16], rsi
	mov rdx, 256
	push rdx
	call read
	mov rbx, [rbp+16]
	mov byte[rbx + rax-1], 0x00
	mov word[rbx + rax], 0x0A0D

	leave
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

	push r15
	call get_path
	mov r15, [rsp]

	push r15
	add rax, 2
	push rax
	call write	

	push word 0x0A0D
	push rsp
	push 2
	call write

	;mov rsi, 0x0
	push 7777o
	push r15
	call chmod

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

	push 1
	call exit 











