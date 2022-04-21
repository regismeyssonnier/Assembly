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

nanosleep:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 35  
	mov rdi, [rbp+16]  ; req
	mov rsi, [rbp+24] ; rem
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

pause:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 34
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

alarm:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	;xor rdi,rdi
	mov rax, 37  ; exit syscall
	mov rdi, [rbp+16]   ; 
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
	mov rax, 999999999
	push rax
	push qword 2
	mov r14, rsp

	push qword 0
	push qword 0
	mov r15, rsp
	
	push r15
	push r14
	call nanosleep

	cmp rax, 0
	jne error

	push 5
	call alarm
	

	push word 0x0A0D
	mov rsi, '!!!!!!  '
	push rsi
	mov rsi, 'MMMMMM !'
	push rsi
	mov rsi, ' BOOOOOM'
	push rsi
	mov rsi, 'Finished'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,34
	push rdx
	call write

	call pause
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




















