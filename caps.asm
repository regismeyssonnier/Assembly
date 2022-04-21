;arg x86_64        rdi   rsi   rdx   r10   r8    r9    -

section	.text
    	global _start

_start:
	jmp main

getpid:
	enter 0, 0
	mov rax, 39   
	syscall  
	leave
	ret

capset:
	enter 0, 0
	mov rax, 126
	mov rdi, [rbp+24]  
	mov rsi, [rbp+16] 
	syscall  
	leave
	ret

exit:
	enter 0, 0
	mov rax, 60 
	mov rdi, 1
	syscall  
	leave
	ret


main:

	sub rsp, 64
	mov r14, rsp

	mov qword[r14], 0x20080522
	call getpid
	mov qword[r14+8], rax

	sub rsp, 64
	mov r13, rsp

	mov qword[r13], 0xffffffffffffffff
	mov qword[r13+8], 0xffffffffffffffff
	mov qword[r13+16], 0xffffffffffffffff

	push r14
	push r13
	call capset


	jmp exit







