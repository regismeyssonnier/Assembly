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

fork:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 57
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
	
	call fork
	cmp rax, 0
	jne father

	push word 0x0A0D
	mov rsi, '!!!!!   '
	push rsi
	mov rsi, 'oules !!'
	push rsi
	mov rsi, 'es bougn'
	push rsi
	mov rsi, ' NIQUE l'
	push rsi
	mov rsi, 'your Son'
	push rsi
	mov rsi, 'This is '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,50
	push rdx
	call write

	push qword 0;100000000
	push qword 10
	mov r14, rsp

	push qword 0
	push qword 0
	mov r15, rsp
	
	push r15
	push r14
	call nanosleep

	push word 0x0A0D
	mov rsi, '!!      '
	push rsi
	mov rsi, '!!!!!!!!'
	push rsi
	mov rsi, 'BEEF !!!'
	push rsi
	mov rsi, 'SON DEAD'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,34
	push rdx
	call write

	call exit

father:

	push word 0x0A0D
	mov rsi, ' !!!!!!!'
	push rsi
	mov rsi, 'herboard'
	push rsi
	mov rsi, 'your Mot'
	push rsi
	mov rsi, 'This is '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,34
	push rdx
	call write
	
	sub rsp, 128
	mov r15, rsp

	push 0
	push 0
	push r15
	push 4
	call waitid

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
	mov rsi, '!       '
	push rsi
	mov rsi, 'ss !!!!!'
	push rsi
	mov rsi, 'ck you a'
	push rsi
	mov rsi, ' !!!! Fu'
	push rsi
	mov rsi, 'DEADBEEF'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,42
	push rdx
	call write

	


	call exit





