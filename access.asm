;arg x86_64        rdi   rsi   rdx   r10   r8    r9    -

section	.text
    	global _start
_start:
	jmp main


write:
	enter 0, 0
	mov rax, 1   
	mov rdi, 1   
	mov rsi, [rbp+24] 
	mov rdx, [rbp+16]  
	syscall  
	leave
	ret

read:
	enter 0, 0
	mov rax, 0   
	mov rdi, 0   
	mov rsi, [rbp+24] 
	mov rdx, [rbp+16] 
	syscall  
	leave
	ret

access:
	enter 0, 0
	mov rax, 21 
	mov rdi, [rbp+24] 
	mov rsi, [rbp+16] 
	syscall  
	leave
	ret


exit:
	enter 0, 0
	mov rax, 60 
	mov rdi, 1
	syscall  
	leave
	ret


main:

	push word 0x0A0D
	mov rsi, 'me :    '
	push rsi
	mov rsi, 'e pathna'
	push rsi
	mov rsi, 'Enter th'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,26
	push rdx
	call write

	push word 0x0A0D
	sub rsp, 256
	push rsp
	mov r15, [rsp]
	mov rdx, 256
	push rdx
	call read
	mov byte[r15 + rax-1], 0x00
	mov word[r15 + rax], 0x0A0D

	push r15
	add rax, 2
	push rax
	call write	

	push word 0x0A0D
	push rsp
	push 2
	call write

	xor r14, r14
	push r14
	mov r14, rsp
	
	push r15
	push 4 
	call access
	cmp rax, 0
	je read_ok
		
next:
	push r15
	push 2
	call access
	cmp rax, 0
	je write_ok

next2:
	push r15
	push 1
	call access
	cmp rax, 0
	je exec_ok

next3:
	cmp qword[r14], 1
	jge end
	jmp no_rwx
	

read_ok:
	inc qword[r14]

	push word 0x0A0D
	mov rsi, 'Read OK '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,10
	push rdx
	call write
	jmp next
	

write_ok:
	inc qword[r14]

	push word 0x0A0D
	mov rsi, 'Write OK'
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,10
	push rdx
	call write
	jmp next2 
	

exec_ok:
	inc qword[r14]

	push word 0x0A0D
	mov rsi, 'Exec OK '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,10
	push rdx
	call write
	jmp next3

no_rwx:
	push word 0x0A0D
	mov rsi, 'No RWX  '
	push rsi
	push rsp
	xor rdx,rdx
	add rdx,10
	push rdx
	call write

	
end:

	call exit







