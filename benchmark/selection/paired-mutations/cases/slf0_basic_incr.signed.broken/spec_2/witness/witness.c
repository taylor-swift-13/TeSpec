#include <stdio.h>
#include <limits.h>
void incr(int *p)

{ int n = *p; int m = n+1; *p = m; }
int main(void) { int cell = 7; incr(((int*)0)); printf("%lld\n", (long long)cell); return 0; }
