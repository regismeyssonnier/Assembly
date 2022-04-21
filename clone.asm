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

waitid:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 247   
	mov rdi, [rbp+40] 
	mov rsi, [rbp+32] 
	mov rdx, [rbp+24] 
	mov r10, [rbp+16] 
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

clone:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 56   
	mov rdi, 0;[rbp+16] 
	mov rsi, 0;[rbp+24] 
	mov rdx, 0;[rbp+24] 
	mov r10, 0;[rbp+16] 
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

thread_clone:
	;enter 0, 0

	push qword 0;100000000
	push qword 5
	mov r14, rsp

	push qword 0
	push qword 0
	mov r15, rsp
	
	mov rsi, r15
	mov rdi, r14
	mov rax, 35
	;syscall

	push word 0x0A0D
	mov rsi, 'Child   '
	push rsi
	mov rsi, rsp
	xor rdx,rdx
	add rdx,10
	;push rdx

	mov rax, 1   ; use the write syscall
	mov rdi, 1   ; write to stdout
	;mov rsi, [rbp+24] ; use string "Hello World"
	;mov rdx, rdx  ; write 12 characters
	syscall
	
	mov rax, 60  ; exit syscall
	mov rdi, 1
	;xor rsi, rsi
	;xor rdx, rdx  
	;syscall  
	
	;call exit
	;leave
	ret


main:

	push word 0x0A0D
	mov rsi, '!!!     '
	push rsi
	mov rsi, 'y !!!!!!'
	push rsi
	mov rsi, 'ead read'
	push rsi
	mov rsi, 'Main thr'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,34
	push rdx
	call write

	xor rax, rax

	sub rsp, 4096
	;push thread_clone
	;add rsp, 4096
	push rsp
	push  67108881;-2147381504;
	;push 0
	call clone
	

	cmp rax, 0
	je wait1
	cmp rax, -1
	je error

	
	
	push word 0x0A0D
	mov rsi, 'END     '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,10
	push rdx
	call write

	push qword 0;100000000
	push qword 5
	mov r14, rsp

	push qword 0
	push qword 0
	mov r15, rsp
	
	push r15
	push r14
	call nanosleep

	push word 0x0A0D
	mov rsi, 'ILD     '
	push rsi
	mov rsi, 'FINAL CH'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,18
	push rdx
	call write 

	call exit

wait1:

	sub rsp, 1024
	push word 0x0A0D
	mov rsi, 'END MAIN'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,10
	push rdx
	call write

	sub rsp, 128
	mov r15, rsp


	push 0
	push 0
	push r15
	push 4
	call waitid

	push word 0x0A0D
	mov rsi, '!!!     '
	push rsi
	mov rsi, 'FINAL !!'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,18
	push rdx
	call write
	
	call exit

error:

	push word 0x0A0D
	mov rsi, '!!!!    '
	push rsi
	mov rsi, '!!!!!!!!'
	push rsi
	mov rsi, 'CKT UP !'
	push rsi
	mov rsi, 'ERROR FU'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,34
	push rdx
	call write











