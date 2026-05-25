.intel_syntax noprefix

.section .bss
src: .space 30000

tape: .space 30000

.section .data
code: .ascii "+++>>><<<---.\n"

.section .text
.global _start

_start:

# -------------------------
# print code (debug)
# -------------------------
  mov rax, 1
  mov rdi, 1
  lea rsi, [rip + code]
  mov rdx, 14
  syscall

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

# -------------------------
# read loop
# -------------------------
read:
  mov rax, 0
  mov rdi, r12
  lea rsi, [rip + src]
  mov rdx, 30000
  syscall

  cmp rax, 0
  jle close

# write back
  mov rdx, rax
  mov rax, 1
  mov rdi, 1
  lea rsi, [rip + src]
  syscall

  jmp read

# -------------------------
close:
  mov rax, 3
  mov rdi, r12
  syscall

# -------------------------
# REAL interpreter setup
# -------------------------
  lea r13, [rip + src]   # instruction pointer
  lea r9, [rip + tape]   # data pointer

# -------------------------
# interpreter loop
# -------------------------
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
    mov rax, 0
    mov rdi, 0
    syscall
    mov [r9], al

# -------------------------
# loops NOT implemented yet (intentionally)
# -------------------------
  .lb:
    cmp al, '['
    jne .rb

  .rb:
    cmp al, ']'
    jne .loopb
    jmp m

  .loopb:
    inc r13
    jmp m

# -------------------------
exit:
  mov rax, 60
  xor rdi, rdi
  syscall
