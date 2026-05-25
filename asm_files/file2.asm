.intel_syntax noprefix

.section .bss
buffer:
    .space 1024

.section .text
    .global _start

_start:
    mov rax, [rsp]

    cmp rax, 2
    jl exit

    mov rdi, [rsp + 16]
    mov rax, 2          
    mov rdi, buffer  
    mov rsi, 0        
    mov rdx, 0
    syscall

    mov r12, rax

    mov rax, 0          
    mov rdi, r12       
    mov rsi, buffer    
    mov rdx, 1024     
    syscall

    mov r13, rax

    mov rax, 1 
    mov rdi, 1
    mov rsi, buffer
    mov rdx, r13
    syscall

    mov rax, 3
    mov rdi, r12
    syscall

exit:
    mov rax, 60 
    xor rdi, rdi
    syscall
