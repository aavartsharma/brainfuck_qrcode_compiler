int _start(void) {
  char hello[] = "hello world!\n";
  asm volatile (
      "mov $1, %%rax\n"
      "mov $1, %%rdi\n"
      "lea %0, %%rsi\n"
      "mov $14, %%rdx\n"
      "syscall\n"
      :
      : "m"(hello)
      : "rax", "rdi", "rsi", "rdx"
  );
  asm volatile (
      "mov $60, %%rax\n"
      "mov $0, %%rdi\n"
      "syscall\n"
      ::: "rax", "rdi"
  );
  return 0;
}
