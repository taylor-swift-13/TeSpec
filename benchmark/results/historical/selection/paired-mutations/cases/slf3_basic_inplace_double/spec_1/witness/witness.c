#include <stdio.h>
#include <limits.h>
void inplace_double(int *p)

{ int n = *p; int m = n+n; *p = m; }
int main(void) { int cell = 5; inplace_double(&cell); printf("%lld\n", (long long)cell); return 0; }
