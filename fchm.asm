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

fchmod:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 91  
	mov rdi, [rbp+16]   
	mov rsi, [rbp+24]
	xor rdx, rdx  
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
	mov rsi, 'lename :'
	push rsi
	mov rsi, 'Enter fi'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,18
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
	

	push r15
	push rax
	call write
	mov byte[r15 + rax-1], 0


	push r15
	push 2
	call open

	push 7777o
	push rax
	call fchmod

	call close

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
















