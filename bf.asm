.intel_syntax noprefix

.section .bss

src:
  .space 30000
tape:
  .space 30000

.section .data
code:
  .ascii "+++>>><<<---.\n"

.section .text
  .global _start

_start:
  mov rax, 1        
  mov rdi, 1       
  lea rsi, [code]  
  mov rdx, 14       
  syscall
 
  mov rax, 2  # make open syscall 
  mov rdi, [rsp+16]
  mov rsi, 0
  mov rdx, 0 
  syscall

  cmp rax, 0
  jle close
  mov r12, rax # to preserve the file discrpertor

read:
  # Read from file (sys_read)
  mov rax, 0          # syscall number for read
  mov rdi,  r12      # 1st arg: fd 
  lea rsi, [rip+src]     # 2nd arg: buffer address
  mov rdx, 30000       # 3rd arg: max bytes to read
  syscall
 
  # Exit on EOF (rax == 0) or error (rax < 0)
  cmp rax, 0
  jle close

  #Write buffer to stdout (sys_write)
  mov rdx, rax        # Bytes to write (from read)
  mov rax, 1          # syscall number for write
  lea rsi, [rip+src]     # 2nd arg: buffer address
  mov rdi, 1          # 1st arg: stdout (FD=1)
  syscall
 
  jmp read      # Repeat until EOF
 
close:
  # Close the file
  mov rax, 3
  syscall             # rdi still holds FD

  mov rax, 1        
  mov rdi, 1       
  lea rsi, [code]  
  mov rdx, 14       
  syscall

m:
  mov al, byte ptr [rip+src+1] 
  .check_plus:
    cmp al, '+'
    jne .check_minus
    inc byte PTR [tape]
    jmp .next

  .check_minus:
    cmp al, '-'
    jne .check_left
    dec byte PTR [tape]
    jmp .next

  .check_left:
    cmp al, '<'
    jne .check_right
    dec esi
    jmp .next

  .check_right:
    cmp al, '>'
    jne .check_dot
    inc esi
    jmp .next

  .check_dot:
    cmp al, '.'
    jne .check_comma

    jmp .next

  .check_comma:
    cmp al, ','
    jne .check_left

    jmp .next

  .check_l:
    cmp al, '['
    jne .check_r
    #mov r5, [esi]
    #.r:
    #  cmp al,
    #  jge .next
      
    #.j:
      #cmp al,
    jmp .next

  .check_r:
    cmp al, ']'
    jne .next
    jmp exit 

#  .loop_rec:
#    cmp byte ptr [esi], 0
#    je  .skip_loop

#    lea eax, [edi+1]
#    push eax             
#    push esi             # tape
#    call m
#    add esp, 8

#    jmp .loop_rec

#.skip_loop:
#  .find_end:
#    cmp byte [edi], ']'
#    je .next

#    inc edi
#    jmp .find_end

  .next:
    inc byte ptr src
    jmp m

exit:
  mov rax, 60
  xor rdi, rdi
  syscall
  
