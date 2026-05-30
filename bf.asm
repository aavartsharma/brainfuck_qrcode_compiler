.intel_syntax noprefix

.section .bss
src: .space 30000
tape: .space 30000

.section .text
.global _start

_start:
# -------------------------
# open file (ARGV safe)
# -------------------------
  mov rdi, [rsp + 16]     # argv[1]
  mov rax, 2              # open (simple version)
  xor rsi, rsi            # O_RDONLY
  xor rdx, rdx
  syscall
  cmp rax, 0
  jle exit
  mov r12, rax           # fd
read:
  mov rax, 0
  mov rdi, r12
  lea rsi, [rip + src]
  mov rdx, 30000
  syscall
  cmp rax, 0
  jg read
close:
  mov rax, 3
  mov rdi, r12
  syscall
  lea r13, [rip + src]   # instruction pointer
  lea r9, [rip + tape]   # data pointer
m:
  mov al, [r13] 
  cmp al, 0
  je exit

  .plus:
    cmp al, '+'
    jne .minus
    inc byte ptr [r9]

  .minus:
    cmp al, '-'
    jne .left
    dec byte ptr [r9]

  .left:
    cmp al, '<'
    jne .right
    dec r9

  .right:
    cmp al, '>'
    jne .dot
    inc r9

  .dot:
    cmp al, '.'
    jne .comma 
    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    mov rsi, r9
    syscall

  .comma:
    cmp al, ','
    jne .lb
    xor rax, rax
    xor rdi, rdi
    syscall
    mov [r9], al

  .lb:
    cmp al, '['
    jne .rb
    lea r8, [r13]
    push r8
    lea r8, [r9]
    push r8

  .rb:
    cmp al, ']'
    jne .loopb
    mov al, [r9]
    cmp al, 0
    jne .rep
    pop r8
    pop r8
    jmp .loopb
    .rep:
      mov r13, [rsp+8] 
      
  .loopb:
    inc r13
    jmp m

# -------------------------
exit:
  mov rax, 60
  xor rdi, rdi
  syscall 
