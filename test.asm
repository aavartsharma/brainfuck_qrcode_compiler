.intel_syntax noprefix

.section .bss  # making a array
buffer:
  .space 30000 
tape:
  .space 30000

.section .data
hello:
  .ascii "hello world!\n\0" # aa
filename:
  .asciz "main.c"

.section .text
  .global _start


_start:
  mov rax, 1        
  mov rdi, 1       
  lea rsi, [hello]  
  mov rdx, 14       
  syscall
  jmp read

read:
  mov rax, [rsp]
  mov rdi, [rsp+16]
  mov rsi, 0
  mov rdx, 0 
  syscall

  cmp rax, 0
  jle close


read_loop:
  # Read from file (sys_read)
  mov rax, 0          # syscall number for read
  mov rdi, rax
  lea rsi, buffer     # 2nd arg: buffer address
  mov rdx, 1024       # 3rd arg: max bytes to read
  syscall
 
  # Exit on EOF (rax == 0) or error (rax < 0)
  cmp rax, 0
  jle close

  #Write buffer to stdout (sys_write)
  mov rdx, rax        # Bytes to write (from read)
  mov rax, 1          # syscall number for write
  lea rsi, buffer     # 2nd arg: buffer address
  mov rdi, 1          # 1st arg: stdout (FD=1)
  syscall
 
  jmp read_loop       # Repeat until EOF
 
close:
  # Close the file
  mov rax, 3
  syscall             # rdi still holds FD

  mov rax, 1        
  mov rdi, 1       
  lea rsi, [hello]  
  mov rdx, 14       
  syscall


exit:
  mov rax, 60       
  xor rdi, rdi
  syscall
