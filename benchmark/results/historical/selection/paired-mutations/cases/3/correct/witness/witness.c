#include <stdio.h>
#include <limits.h>
void zero(int *p)

{ *p = 0; }
int main(void) { int cell = 7; zero(&cell); printf("%lld\n", (long long)cell); return 0; }
