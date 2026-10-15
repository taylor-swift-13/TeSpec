#include <stdio.h>
#include <limits.h>
void zero(int *p)

{ *p = 0; }
int main(void) { int cell = 7; zero(((int*)0)); printf("%lld\n", (long long)cell); return 0; }
