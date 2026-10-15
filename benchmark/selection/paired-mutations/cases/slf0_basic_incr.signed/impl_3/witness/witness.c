#include <stdio.h>
#include <limits.h>
void incr(int *p)

{ *p = 0; }
int main(void) { int cell = 5; incr(&cell); printf("%lld\n", (long long)cell); return 0; }
