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

open:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	mov rax, 2   ; open syscall
	mov rdi, [rbp+24]   ; file desc
	mov rsi, [rbp+16] ; code
	mov rdx, 0  
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

dup2:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 33
	mov rdi, [rbp+24]  
	mov rsi, [rbp+16]  
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

writef:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	xor rdi,rdi
	mov rax, 1   ; use the write syscall
	mov rdi, [rbp+32]   ; write to fd
	mov rsi, [rbp+24] ; buffer
	mov rdx, [rbp+16]  ; write n characters
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

iopl:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 172
	mov rdi, [rbp+16] 
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

analyze_k:

	enter 0, 0

	mov rsi, [rbp + 24]

	and rsi, 0x80
	cmp rsi, 0x80
	jne ank1

	mov byte[rbp + 16], 1
	jmp ank_e
	
ank1:
	mov byte[rbp + 16], 0
	
ank_e:
	

	leave
	ret

creat:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 85
	mov rdi, [rbp+24] 
	mov rsi, [rbp+16]  
	syscall  
	leave
	;mov rsp, rbp
	;pop rbp
	ret

open_file:

	enter 0, 0
	
	xor rsi, rsi
	push rsi
	mov rsi, 'kf.k'
	push rsi
	push rsp
	push 7777o
	call creat

	push rax 
	call close

	xor rsi, rsi
	push rsi
	mov rsi, 'kf.k'
	push rsi
	push rsp
	push 3074 ;2050
	call open

	push rax
	push 0x25
	call dup2
	cmp rax, -1
	je exit
	
	leave
	ret

close:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	;xor rdi,rdi
	mov rax, 3   ; open syscall
	mov rdi, [rbp+16]   ; file desc
	mov rsi, 0 ; code
	mov rdx, 0  
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

	
	xor rsi, rsi
	mov rcx, 0
init_kt:
	push rsi
	inc rcx
	cmp rcx, 30
	jne init_kt
	mov r15, rsp

	call open_file
	
	
	mov rsi, 'azertyui'
	mov qword[rsp+0x10], rsi
	mov si, 'op'
	mov word[rsp+0x18], si

	mov rsi, 'qsdfghjk'
	mov qword[rsp+0x1e], rsi
	mov si, 'lm'
	mov word[rsp+0x26], si

	mov rsi, 'wxcvbn,.'
	mov qword[rsp+0x2c], rsi
	mov si, '/!'
	mov word[rsp+0x34], si

	mov sil, ' '
	mov byte[rsp+0x39], sil

	mov rsi, '789-456+'
	mov qword[rsp+0x47], rsi	
	mov rsi, '1230.'
	mov qword[rsp+0x4f], rsi
	

	push 0x25
	push r15
	push 240
	call writef
	cmp rax, 240
	jne exit

	push 0x25
	call close

	
	;add r15, 0x10
	push r15
	xor rdx,rdx
	add rdx,240;0x28
	push rdx
	call write

	push word 0x0A0D
	push rsp
	push 2
	call write

	call exit











