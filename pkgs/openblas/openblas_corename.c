#include <stdio.h>

int main(int argc, char * argv[]) {
  printf("%s", get_corename());
  fflush(stdout);
  return 0;
}
