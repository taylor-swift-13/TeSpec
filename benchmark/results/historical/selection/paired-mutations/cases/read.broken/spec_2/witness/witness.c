#include <stdio.h>
#include <limits.h>
int read(int *p)

{ return *p; }
int main(void) { int cell = 7; long long result = read(((int*)0)); printf("%lld %lld\n",result,(long long)cell); return 0; }
