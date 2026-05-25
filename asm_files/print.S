.intel_syntax noprefix
.section .data
.section bss
buffer:
  .skip 1024
.section .text
  global _start
_start:
  mov rax, 2          ; syscall number for open
  mov rdi, filename   ; 1st arg: filename
  mov rsi, 0          ; 2nd arg: O_RDONLY (read-only)
  mov rdx, 0          ; 3rd arg: file mode (0 for read)
  syscall
 
  cmp rax, 0
  jle close  
  mov rdi, rax       

read_loop:
    ; Read from file (sys_read)
    mov rax, 0          ; syscall number for read
    mov rsi, buffer     ; 2nd arg: buffer address
    mov rdx, 1024       ; 3rd arg: max bytes to read
    syscall
 
    ; Exit on EOF (rax == 0) or error (rax < 0)
    cmp rax, 0
    jle close
 
    ; Write buffer to stdout (sys_write)
    mov rdx, rax        ; Bytes to write (from read)
    mov rax, 1          ; syscall number for write
    mov rsi, buffer     ; 2nd arg: buffer address
    mov rdi, 1          ; 1st arg: stdout (FD=1)
    syscall
 
    jmp read_loop       ; Repeat until EOF
 
close:
    ; Close the file
    mov rax, 3
    syscall             ; rdi still holds FD
 
exit_program:
    ; Exit successfully
    mov rax, 60
    mov rdi, 0
    syscall
