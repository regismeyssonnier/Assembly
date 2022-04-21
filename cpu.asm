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

getcpu:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 309
	mov rdi, [rbp+32]
	mov rsi, [rbp+24]
	mov rdx, [rbp+16]
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

	enter 0, 0
	xor rsi, rsi
	push rsi
	mov r15, rsp

	xor rsi, rsi
	push rsi
	mov r14, rsp

	mov r13, 0

	push r15
	push r14
	push r13
	call getcpu

	cmp qword[rsp], 0
	jne error

	push word 0x0A0D
	add qword[r15], 0x30
	mov rsi, '        '
	mov sil, byte[r15]
	push rsi
	mov rsi, 'CPU :   '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,18
	push rdx
	call write

	push word 0x0A0D
	add qword[r14], 0x30
	mov rsi, '        '
	mov sil, byte[r14]
	push rsi
	mov rsi, 'NODE :  '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,18
	push rdx
	call write

	
	push qword 100000000
	push qword 0
	mov r14, rsp

	push qword 0
	push qword 0
	mov r15, rsp
	
	push r15
	push r14
	call nanosleep
	leave
	jmp main


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





