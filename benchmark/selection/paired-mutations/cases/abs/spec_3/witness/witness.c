#include <stdio.h>
#include <limits.h>
int abs(int x)

{ if (x >= 0) { return x; } else { return -x; } }
int main(void) { long long result = abs((-2147483647-1)); printf("%lld\n",result); return 0; }
