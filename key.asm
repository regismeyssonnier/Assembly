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

	push 0
	call iopl

	xor rsi, rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	push rsi
	mov r15, rsp


	push rsi
	push rsi
	push rsi
	push rsi
	mov r14, rsp

	mov byte[r14], 0x10
	mov byte[r14+2], 1
	mov word[r14+4], 0x7C00
	mov qword[r14+8], 50	

	;DAPACK:
	;db 0x10
	;db 0
	;blkcnt: dw 16	; int 13 resets this to # of blocks actually read/written
	;db_add: dw 0x7C00 ; memory buffer destination address (0:7c00)
	;dw 0 ; in memory page zero
	;d_lba: dd 1 ; put the lba to read in this spot
	;dd 0 ; more storage bytes only for big lba's ( > 4 bytes )

	xor rax, rax
	xor rdx, rdx
	xor rsi, rsi
	mov ah, 0x42
	mov dl, 0x80
	mov si, r14w
	int 0x13
	jc exit

	push word 0x0A0D
	mov rsi, 'key :   '
	;mov sil, al
	push rsi
	push rsp
	mov byte[rsp+14], al
	xor rdx,rdx
	add rdx,10
	push rdx
	call write
	add rsp, 34






	call exit




