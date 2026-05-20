#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

char *m(unsigned char *tape,char *src){
  while(*src) {
    char ch=*(src);
    if(*(src)=='+') (*tape)++;
    else if (*(src)=='-') (*tape)--;
    else if (*(src)=='<') tape--;
    else if (*(src)=='>') tape++;
    else if ((*src)=='.') putchar((char)*tape);
    else if ((*src)==',') read(0,tape,1);
    else if ((*src)=='[') {
      while(*tape) m(tape,src+1);
      while(*src!=']') src++; 
    }
    else if ((*src)==']') return (src+1);
    src++;
  }
}

int main(int argc, char **argv) {
  FILE *f = fopen(argv[1],"r");
  if (!f) {
    printf("ERROR: in read_file");
    return -1;
  } 
  fseek(f,0, SEEK_END);
  size_t size = ftell(f);
  rewind(f);

  char *buffer = (char *)malloc(size +1);
  if (!buffer) {
    fclose(f); 
    printf("ERROR: in read_file");
    return -1;
  }
  fread(buffer, 1, size, f);
  buffer[size] = '\0';
  fclose(f);
  unsigned char ta[30000]={0};

  m(ta,buffer);
  return 0;
}
