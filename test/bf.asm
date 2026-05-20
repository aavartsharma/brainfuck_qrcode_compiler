.intel_syntax noprefix

.section .text
.global _start
_start:
  mov rax, 1 
  mov rdi, 1
  mov rsi ,64 
  mov rdx, 14 
  syscall

exit:
  mov al, 60
  xor edi, edi
  syscall
