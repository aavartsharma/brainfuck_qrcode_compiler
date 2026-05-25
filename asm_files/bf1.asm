.intel_syntax noprefix

.section .bss

.section .data
buffer:
  .ascii "+++>>><<<---."

.section .text
  .global _start

_start:
  

.loop:
    mov     al, [edi]
    test    al, al
    jz      .done
.check_plus
    cmp al, '+'
    jne .check_minus
    inc byte [esi]
    jmp .next

.check_minus:
    cmp al, '-'
    jne .check_left
    dec byte [esi]
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

    movzx eax, byte [esi]
    push eax
    call putchar
    add esp, 4
    jmp .next

.check_comma:
    cmp al, ','
    jne .check_left

    mov eax, [stdin]
    push eax
    call fgetc
    add esp, 4

    mov [esi], al
    jmp .next

.check_left:
    cmp al, '['
    jne .check_right
    mov r5, [esi]
    .r:
      cmp al,
      jge .next
      
    .j:
      cmp al,
    jmp .next

.check_right:
    cmp al, ']'
    jne .next
    jmp .done

.loop_rec:
    cmp byte [esi], 0
    je  .skip_loop

    lea eax, [edi+1]
    push eax             
    push esi             # tape
    call m
    add esp, 8

    jmp .loop_rec

.skip_loop:
.find_end:
    cmp byte [edi], ']'
    je .next

    inc edi
    jmp .find_end

.next:
    inc edi
    jmp .loop
