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

setpriority:
	enter 0, 0
	;push rbp
	;mov rbp, rsp
	xor rax,rax
	xor rdi,rdi
	mov rax, 141   ; use the getpid syscall
	mov rdi, [rbp+16]   
	mov rsi, [rbp+24] 
	mov rdx, [rbp+32]  
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

is_in:
	enter 0, 0

	mov r8b, [rbp+32]
	mov r9b, [rbp+24]
	mov r10, [rbp+16]
	mov rax, 0

	mov rbx, 0

lp:
	cmp byte[r10+rbx], r8b
	jne inclp
	cmp byte[r10+rbx+1], r9b
	jne inclp
	je end_is_in1
	
inclp:
	add rbx, 2
	cmp rbx, r12
	jge end_is_in0
	jmp lp
		
end_is_in0:
	mov rax, 0
	jmp end_is_in2

end_is_in1:
	mov rax, 1

end_is_in2:
	

	leave
	ret

;-------------------------------------
get_numbers:
	enter 0, 0
	
	mov rsi, [rbp+32]
	mov rdi, [rbp+24]
	mov rdx, [rbp+16]

	mov rcx, 0
	mov rbx, 0
tchns:	
	cmp byte[rsi+rcx], 0x30
	je ones
	cmp byte[rsi+rcx], 0x31
	jg inc_tchns
	cmp byte[rsi+rcx+1], 0x30
	jg inc_tchns
	jmp addns
	
ones:
	cmp byte[rsi+rcx+1], 0x31
	jl inc_tchns

addns:
	mov r10, 0
	mov r10b, byte[rsi+rcx]
	push r10
	mov r10, 0
	mov r10b, byte[rsi+rcx+1]
	push r10
	mov r10, r13
	add r10, 10
	push r10
	call is_in
	cmp rax, 1
	je inc_tchns

	mov r10b, byte[rsi+rcx]
	mov byte[rdi+rdx], r10b
	mov r10b, byte[rsi+rcx+1]
	mov byte[rdi+rdx+1], r10b
	
	jmp end_tchns
	
inc_tchns:
	add rcx, 2
	cmp rcx, 4096
	je end_tchns
	jmp tchns	

end_tchns:

	leave
	ret
;------------------------------------

get_number:
	enter 0, 0
	
	mov rsi, [rbp+32]
	mov rdi, [rbp+24]
	mov rdx, [rbp+16]

	mov rcx, 0
	mov rbx, 0
tchn:	
	cmp byte[rsi+rcx], 0x30
	je one
	cmp byte[rsi+rcx], 0x34
	jle addn
	jg inc_tchn
	;cmp byte[rsi+rcx+1], 0x30
	;jg inc_tchn
	
one:
	cmp byte[rsi+rcx+1], 0x31
	jl inc_tchn

addn:
	mov r10, 0
	mov r10b, byte[rsi+rcx]
	push r10
	mov r10, 0
	mov r10b, byte[rsi+rcx+1]
	push r10
	push r13
	call is_in
	cmp rax, 1
	je inc_tchn

	mov r10b, byte[rsi+rcx]
	mov byte[rdi+rdx], r10b
	mov r10b, byte[rsi+rcx+1]
	mov byte[rdi+rdx+1], r10b
	
	jmp end_tchn
	
inc_tchn:
	add rcx, 2
	cmp rcx, 4096
	je end_tchn
	jmp tchn	

end_tchn:

	leave
	ret

;-----------------------------
get_5:
	enter 0, 0

sgr:
	push r15
	push 4096
	push 1;2048
	call getrandom

	
	cmp rax, -1
	je error

	
start:

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

	push r14
	push r13
	push r12
	call get_number
	

	add r12, 2
	cmp r12, 10
	jl sgr

	leave
	ret

;--------------------------------
get_STAR:

	enter 0, 0

sgrs:
	push r15
	push 4096
	push 1;2048
	call getrandom

	
	cmp rax, -1
	je error

starts:

	mov rcx, 0
	mov rbx, 0
chns:
	cmp byte[r15+rcx], 0x30
	jl inc_chns
	cmp byte[r15+rcx], 0x39
	jg inc_chns
	mov sil, byte[r15+rcx]
	mov byte[r14+rbx], sil
	inc rbx	
	cmp rbx, 4096
	je end_chns
inc_chns:
	inc rcx
	cmp rcx, 4096
	je end_chns
	jmp chns
end_chns:

	
	push r14
	push r13
	push r12
	call get_numbers
	

	add r12, 2
	cmp r12, 12
	jl sgrs

	leave
	ret
	

main:

	call getpid

	push -20
	push rax
	push 0
	call setpriority

	sub rsp, 4096
	mov r15, rsp

	sub rsp, 64
	mov r14, rsp
	
	sub rsp, 64
	mov r13, rsp

	mov r12, 0

	call get_5
	
	call get_STAR

	push word 0x0A0D
	mov rsi, '        '

	push rsi
	mov byte[rsp], ' '
	mov r10w, word[r13+6]
	mov word[rsp+1], r10w
	mov byte[rsp+3], ' '
	mov r10w, word[r13+8]
	mov word[rsp+4], r10w
	mov byte[rsp+6], ' '

	push rsi
	mov r10w, word[r13]
	mov word[rsp], r10w
	mov byte[rsp+2], ' '

	mov r10w, word[r13+2]
	mov word[rsp+3], r10w
	mov byte[rsp+5], ' '

	mov r10w, word[r13+4]
	mov word[rsp+6], r10w
	
	
	mov rsi, 'rnd :   '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,26
	push rdx
	call write

	push word 0x0A0D
	mov rsi, '        '

	push rsi
	mov byte[rsp], ' '
	mov r10w, word[r13+10]
	mov word[rsp+1], r10w
	mov byte[rsp+3], ' '
	mov r10w, word[r13+12]
	mov word[rsp+4], r10w
	mov word[rsp+6], '  '

	mov rsi, 'rnd :   '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,18
	push rdx
	call write


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











