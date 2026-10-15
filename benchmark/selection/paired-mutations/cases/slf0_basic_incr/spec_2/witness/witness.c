#include <stdio.h>
#include <limits.h>
void incr(unsigned int *p)

{ unsigned int n = *p; unsigned int m = n+1; *p = m; }
int main(void) { unsigned int cell = 7; incr(((unsigned int*)0)); printf("%lld\n", (long long)cell); return 0; }
