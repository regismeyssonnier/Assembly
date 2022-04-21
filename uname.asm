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

sethostname:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 170   
	mov rdi, [rbp+24]   
	mov rsi, [rbp+16] 
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

setdomainname:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 171
	mov rdi, [rbp+24]   
	mov rsi, [rbp+16] 
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

uname:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 63  
	mov rdi, [rbp+16]   
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
	mov rsi, 'h ..... '
	push rsi
	mov rsi, '... Bitc'
	push rsi
	mov rsi, 'FUCK UP '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,26
	push rdx
	call write


	mov rsi , 'FUCKNAME'
	push rsi
	push rsp
	push 8
	call sethostname
	cmp rax, 0
	jne error

	mov rsi , 'AIN'
	push rsi
	mov rsi , 'FUCK_DOM'
	push rsi
	push rsp
	push 11
	call setdomainname
	cmp rax, 0
	jne error
	
	
	push word 0x0A0D
	xor rsi, rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	
	
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi

	
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi

	
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi

	
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi

	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi

	;mov rsi, '        '
	;push rsi
	;push rsi
	;push rsi
	;push rsi
	;push rsi
	;push rsi
	;push rsi
	;push rsi
	;push rsi
	
	mov r15, rsp


	push r15
	
	call uname

	;pop r10
	;pop r10
	;pop r11
	;pop r12
	;pop r13
	;pop r14
	;pop r15

	cmp rax, 0
	jne error
	;push word 0x0A0D
	;mov rsi, 's       '
	;push rsi
	;mov rsi, 'n Succes'
	;push rsi
	;mov rsi, 'Operatio'
	;push rsi
	;push rsp
	;xor rdx,rdx
	;add rdx,26
	;push rdx
	;call write

	;push word 0x0A0D
	push r15
	mov rdx, 434
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






