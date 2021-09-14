;assemble  >  nasm -felf64 pyramid.asm
;link    >   ld pyramid.o -o pyramid
;uage example  >   pyramid 20   (20 is the size of the pyramid)

section .data
star: db 0x2A
new_line:	db		0x0A
space: db 0x20
usage_msg: db "Argument error",0x0A,"Syntax: pyramid [integer-number]",0x0A
len:  equ  $-usage_msg

section .text

global _start

_start:

		pop r8  ; number of arguments

        cmp r8,2 ; check number of arguments  (remember that the first argument is the program name)
        jne usage

		pop r10 ; first argument  > prog name
		pop r11 ; second argument which represents the size of our fancy pyramid
		
		;registers initialization 
		mov rcx,0

		mov r8,0
		mov r9,0
		mov rax,1
		mov r12,10

calc_length: ; lets calculate the length of our pyramid size this is going to be useful when
             ;we will convert it to decimal 
		
		cmp byte [r11+rcx],0x00
		
		je atoi
		inc rcx
		jmp calc_length
atoi: ;lets convert the size from ascii to decimal and  eliminate none-digits strings

		dec rcx          

		mov r8b,byte [r11+rcx] 
		
		
        cmp r8,47
        jbe usage
        
        cmp r8,58
        jae usage
		
		sub r8,48 
		push rax  
		mul r8 
		add r9,rax  
		
		pop rax 
		mul r12 

		mov r8,0 
    
		cmp rcx,0         
		jne atoi  

cmp r9,0  ;sanity checking 0 sized pyramid
je exit
print: ; lets print the pyramid
        mov r12,1
        mov r13,1
        mov r14,1
        mov r15,r9
        push r15
        jmp spaces

print1:        

        mov rax,1
		mov rdi,1
		mov rsi,new_line
		mov rdx,1
		syscall
		
		add r12,2
		mov r13,r12
		
		cmp r14,r9
		je exit
		inc r14
		
		dec r15
		cmp r15,0
		je l666
		push r15
		
		spaces:;prints spaces
		
        mov rax,1
		mov rdi,1
		mov rsi,space
		mov rdx,1
		syscall
		
		dec r15
		cmp r15,0
		jnz spaces
		
		pop r15

		l666:;prints stars
		
        mov rax,1
		mov rdi,1
		mov rsi,star
		mov rdx,1
		syscall
		
		dec r13
		cmp r13,0
		je print1
		jmp l666

usage:
        mov rax,1
		mov rdi,1
		mov rsi,usage_msg
		mov rdx,len
		syscall
exit:	

		mov rax,60
		xor rdi,rdi
		syscall







