.intel_syntax noprefix
.global _start

.section .data
hello:
    .ascii "hello world!\n"

.section .text
_start:
    mov rax, 1        
    mov rdi, 1       
    lea rsi, [hello]  
    mov rdx, 14       
    syscall

    mov rax, 60       
    xor rdi, rdi
    syscall
