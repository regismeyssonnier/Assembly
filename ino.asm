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

	push 3
	call iopl

	;xor rax, rax
	;out 0x60, eax

	xor rbx, rbx

	push qword 10000000
	push qword 0
	mov r14, rsp

	push qword 0
	push qword 0
	mov r15, rsp
	
lp:
	push r15
	push r14
	call nanosleep
	add rsp, 16

	
	
	cli
	xor rax, rax
	mov dx, 0x60
	in eax, dx; 0x60
	push rax
	mov al, 0x20
	out 0x20, al
	sti
	

	call display_number
	;pop rax
	;sub eax, 0x10

	push word 0x0A0D
	mov rsi, 'key :   '
	;mov sil, al
	push rsi
	push rsp
	mov word[rsp+14], ax
	xor rdx,rdx
	add rdx,10
	push rdx
	call write
	add rsp, 34
	
	
	inc rbx
	cmp rbx, 1000000
	jl lp	
	
	

	call exit











