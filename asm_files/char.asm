.intel_syntax noprefix

.section .data
hello:
    .ascii "hello world!\n"

.text
  .globl _start
_start:
    mov rax, 1        
    mov rdi, 1       
    lea rsi, [hello]  
    mov rdx, 14       
    syscall

    mov rax, 60       
    xor rdi, rdi
    syscall
