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

getrandom:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	mov rax, 318   
	mov rdi, [rbp+32]
	mov rsi, [rbp+24] 
	mov rdx, [rbp+16]  
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

	sub rsp, 4096
	mov r15, rsp

	sub rsp, 64
	mov r14, rsp

	push r15
	push 4096
	push 1;2048
	call getrandom

	cmp rax, -1
	je error

	mov rcx, 0
	mov rbx, 0
chn:
	cmp byte[r15+rcx], 0x30
	jl inc_chn
	cmp byte[r15+rcx], 0x39
	jg inc_chn
	mov sil, byte[r15+rcx]
	mov byte[r14+rbx], sil
	inc rbx	
	cmp rbx, 4096
	je end_chn
inc_chn:
	inc rcx
	cmp rcx, 4096
	je end_chn
	jmp chn
end_chn:
	

	push word 0x0A0D
	mov rsi, qword[r14+32]
	push rsi
	mov rsi, qword[r14+24]
	push rsi
	mov rsi, qword[r14+16]
	push rsi
	mov rsi, qword[r14+8]
	push rsi
	mov rsi, qword[r14]
	push rsi
	mov rsi, 'rnd :   '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,50
	push rdx
	call write

	call exit

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











