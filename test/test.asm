  .text
  .global  _start
_start:
  movb $0, (%rsp)
  movb $1, %bpl
.Lreadloop:
  movl $.Ldictionary, %esi
.Lscanloop:
  movsbl (%esi), %edx
  movb (%rsp), %cl
  addl $2, %esi
  cmpb %cl, -1(%esi)
  jne .Lscan
  movl %ebp, %eax
  movl %ebp, %edi
  syscall
.Lscan:
  leal 0(%esi, %edx), %esi
  cmpb $0, (%esi)
  jne .Lscanloop
  xorl %eax, %eax
  xorl %edi, %edi
  movq %rsp, %rsi
  movl %ebp, %edx
  syscall
  testl %eax, %eax
  jg .Lreadloop
  movl $.Lclosebrace, %esi
  movl %ebp, %eax
  movl %ebp, %edi
  syscall
  movb $60, %al
  syscall
.Ldictionary:
  .byte 21
  .ascii "\000"
  .ascii "a[65536],*p=a;main(){"
  .byte 4
  .ascii "<"
  .ascii "--p;"
  .byte 4
  .ascii ">"
  .ascii "++p;"
  .byte 5
  .ascii "-"
  .ascii "--*p;"
  .byte 5
  .ascii "+"
  .ascii "++*p;"
  .byte 13
  .ascii ","
  .ascii "*p=getchar();"
  .byte 12
  .ascii "."
  .ascii "putchar(*p);"
  .byte 10
  .ascii "["
  .ascii "while(*p){"
  .byte 1
  .ascii "]"
.Lclosebrace:
  .ascii "}"
