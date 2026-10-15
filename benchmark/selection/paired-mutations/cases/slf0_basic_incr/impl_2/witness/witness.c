#include <stdio.h>
#include <limits.h>
void incr(unsigned int *p)

{ }
int main(void) { unsigned int cell = 5; incr(&cell); printf("%lld\n", (long long)cell); return 0; }
