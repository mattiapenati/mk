#include <stdio.h>

#if defined(__i386__) || defined(__x86_64__) || defined(_M_IX86) || defined(_M_X64)
#define INTEL_AMD
#endif

#if defined(__powerpc__) || defined(__powerpc) || defined(powerpc) || \
    defined(__PPC__) || defined(PPC) || defined(_POWER) || defined(__POWERPC__)
#ifndef POWER
#define POWER
#endif
#endif

#ifdef INTEL_AMD
#include "cpuid_x86.c"
#define OPENBLAS_SUPPORTED
#endif

#ifdef POWER
#include "cpuid_power.c"
#define OPENBLAS_SUPPORTED
#endif

int main(int argc, char * argv[]) {
  printf("%s", get_corename());
  fflush(stdout);
  return 0;
}
