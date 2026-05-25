.intel_syntax noprefix
.section .bss
  .lcomm buffer, 1024
.section .data
hello:
  .ascii "Hello, world!\0"
.section .text
  .global _start

_start:
  mov rax, 1 
  mov rdi, 1
  mov rsi ,64 
  mov rdx, 14 
  syscall

print_char:
  mov rax, 1
  mov rdi ,1
  mov rsi ,r8
  mov rdx, 1
  syscall
  ret

read_char:
  mov rax 0 
  mov rdi, 0
  mov rsi,r8
  mov rdx,1
  syscall
  ret

exit:
  mov al, 60
  xor edi, edi
  syscall

