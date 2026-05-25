#include <stdio.h>
#include <stdlib.h>

void m(unsigned char *tape,char *src){
  while(*src) {
    if(*(src)=='+') (*tape)++;
    else if ((*src)=='-') (*tape)--;
    else if ((*src)=='<') tape--;
    else if ((*src)=='>') tape++;
    else if ((*src)=='.') putchar((char)*tape);
    else if ((*src)==',') *tape = (unsigned char)fgetc(stdin);
    else if ((*src)=='[') {
      while(*tape) m(tape,src+1);
      while(*src!=']') src++; 
    }
    else if ((*src)==']') return;
    src++;
  }
}

int main(int argc, char **argv) {
  FILE *f = fopen(argv[1],"r");
  if (!f) {
    printf("ERROR: in read_file\n");
    return -1;
  } 
  char buffer[30000]={'\0'};
  fread(buffer, 1, 30000, f);
  fclose(f);
  unsigned char ta[30000]={0};

  m(ta,buffer);
  return 0;
}
