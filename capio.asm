;arg x86_64        rdi   rsi   rdx   r10   r8    r9    -

section	.text
    	global _start
_start:
	jmp main

getpid:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	xor rdi,rdi
	mov rax, 39   ; use the getpid syscall
	;mov rdi, 0   
	;mov rsi, 0 
	;mov rdx, 0  
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

capget:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 125
	mov rdi, [rbp+24]  
	mov rsi, [rbp+16] 
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

capset:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 126
	mov rdi, [rbp+24]  
	mov rsi, [rbp+16] 
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

display_number:
	enter 0, 0
	xor rsi, rsi
	xor rdi, rdi

	mov si, word[rbp+16]
	mov di, word[rbp+16]

	and si, 0xf0
	shr si, 4
	cmp sil, 9
	jg dn1
	add si, 0x30
	jmp dn11
dn1:
	add si, 0x37
dn11:

	and di, 0x0f
	cmp dil, 9
	jg dn2
	add di, 0x30
	jmp dn21
dn2:
	add di, 0x37
dn21:

	mov ax, di
	shl rax, 8
	add ax, si
	
	leave
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

	sub rsp, 64
	mov r14, rsp

	sub rsp, 64
	mov r15, rsp


	mov qword[r14], 0x20080522
	call getpid
	mov qword[r14+8], rax

	push r14
	push r15
	call capget

	cmp rax, -1
	je error 

	sub rsp, 64
	mov r13, rsp

	mov qword[r13], 0xffffffffffffffff
	mov qword[r13+8], 0xffffffffffffffff
	mov qword[r13+16], 0xffffffffffffffff

	push r14
	push r13
	call capset
	cmp rax, -1
	je error

	sub rsp, 64
	mov r15, rsp

	push r14
	push r15
	call capget
	cmp rax, -1
	je error

	mov rax, 0x000080f7 ;0xf7800000;
	;mov rsi, qword[rax]
	push rax
	call display_number

	push word 0x0A0D
	mov rsi, 'key :   '
	push rsi
	push rsp
	mov word[rsp+14], ax
	xor rdx,rdx
	add rdx,10
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

















