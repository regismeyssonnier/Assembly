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

lseek:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	;xor rax,rax
	;xor rdi,rdi
	mov rax, 8   ; lseek syscall
	mov rdi, [rbp+32]   ; file desc
	mov rsi, [rbp+24]   ; offset
	mov rdx, [rbp+16]   ; SEEK_END
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
	mov rsi, 'me :    '
	push rsi
	mov rsi, 'e filena'
	push rsi
	mov rsi, 'Enter th'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,26
	push rdx
	call write
	add rsp, 42

	xor rsi, rsi
	push rsi
	push rsi
	push rsi ; reserve 24 bytes
	push rsp
	mov r15, [rsp]
	xor rdx,rdx
	add rdx, 17
	push rdx
	call read
	mov byte[r15 + rax - 1], 0
	

	;push r15
	;push rax
	;call write

	
	push r15
	push 2
	call open
	add rsp, 56

	push rax
	push 0
	push 2
	call lseek
	
	mov qword[rsp], 0
	call lseek
	add rsp, 16
	

	push 1
	call exit


