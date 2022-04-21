;arg x86_64        rdi   rsi   rdx   r10   r8    r9    -

section	.text
    	global _start

_start:
	jmp main

read:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	xor rdi,rdi
	mov rax, 0   ; use the read syscall
	mov rdi, 1   ; to stdout
	mov rsi, [rbp+24] ; use string "Hello World"
	mov rdx, [rbp+16]  ; write 12 characters
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

ipaddress:
	enter 0, 0
	;push rbp
	;mov rbp, rsp

	mov r14, [rbp+16]
	dec r14
	xor rcx, rcx
	xor rbx, rbx
	xor rax, rax
	xor r13, r13
	mov r8, 1
	xor r9, r9
	mov r12, [rbp+24]
	mov r15, [rbp+24]

fp:
	cmp byte[r15 + rax], '.'
	je ip
	inc rbx
	inc rax
	jmp fp

rawip3:
	mov r10b, byte[r12]
	sub r10, 0x30
	imul r10, r10, 100
	add r9, r10
	inc r12
rawip2:
	mov r10b, byte[r12]
	sub r10, 0x30
	imul r10, r10, 10
	add r9, r10
	inc r12
rawip1:
	mov r10b, byte[r12]
	sub r10, 0x30
	add r9, r10
	add r12, 2

	cmp r8, 1
	je storraw1
	cmp r8, 2
	je storraw2
	cmp r8, 3
	je storraw3
	cmp r8, 4
	je storraw4
	
storraw1:
	or r13, r9
	jmp ip2
storraw2:
	shl r9, 8
	or r13, r9
	jmp ip2
storraw3:
	shl r9, 16
	or r13, r9
	jmp ip2
storraw4:
	shl r9, 24
	or r13, r9	
	jmp ip2

ip:
	xor r10, r10
	xor r9, r9
	cmp rbx, 3
	je rawip3
	cmp rbx, 2
	je rawip2
	cmp rbx, 1
	je rawip1

ip2:

	inc rbx
	add rcx, rbx
	xor rbx, rbx
	inc rax
	inc r8
	
	cmp r14, rcx  
	jg fp

	mov rax, r13
	
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
	mov rsi, ' :      '
	push rsi
	mov rsi, ' Address'
	push rsi
	mov rsi, 'Enter IP'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,26
	push rdx
	call write


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
	mov byte[r15 + rax - 1], '.'

	push r15
	push rax
	call ipaddress
	

	push r15
	push rax
	call write


	push 1
	call exit

























