#include <stdio.h>
#include <unistd.h>

static int get_num_cores(void) {
  return sysconf(_SC_NPROCESSORS_ONLN);
}

int main(int argc, char * argv[]) {
  printf("%d", get_num_cores());
  fflush(stdout);
  return 0;
}
