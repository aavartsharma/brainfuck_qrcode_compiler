section .data
    filename db 'test.txt', 0   ; Null-terminated filename
    buffer   resb 1024          ; 1024-byte buffer for reading
    error_msg db 'Error: Could not open file', 10  ; Error message + newline
    error_len equ $ - error_msg ; Length of error_msg
 
section .text
    global _start
 
_start:
    ; Open the file (sys_open)
    mov rax, 2          ; syscall number for open
    mov rdi, filename   ; 1st arg: filename
    mov rsi, 0          ; 2nd arg: O_RDONLY (read-only)
    mov rdx, 0          ; 3rd arg: file mode (0 for read)
    syscall
 
    ; Check for open error
    cmp rax, 0
    jl open_error       ; Jump to error handler if rax < 0
 
    mov rdi, rax        ; Save FD in rdi for read/close
 
read_loop:
    ; Read from file (sys_read)
    mov rax, 0          ; syscall number for read
    mov rsi, buffer     ; 2nd arg: buffer address
    mov rdx, 1024       ; 3rd arg: max bytes to read
    syscall
 
    ; Exit on EOF (rax == 0) or error (rax < 0)
    cmp rax, 0
    jle exit_program
 
    ; Write buffer to stdout (sys_write)
    mov rdx, rax        ; Bytes to write (from read)
    mov rax, 1          ; syscall number for write
    mov rsi, buffer     ; 2nd arg: buffer address
    mov rdi, 1          ; 1st arg: stdout (FD=1)
    syscall
 
    jmp read_loop       ; Repeat until EOF
 
open_error:
    ; Write error to stderr
    mov rax, 1
    mov rdi, 2          ; stderr (FD=2)
    mov rsi, error_msg
    mov rdx, error_len
    syscall
 
    ; Exit with error status
    mov rax, 60
    mov rdi, 1
    syscall
 
exit_program:
    ; Close the file
    mov rax, 3
    syscall             ; rdi still holds FD
 
    ; Exit successfully
    mov rax, 60
    mov rdi, 0
    syscall
