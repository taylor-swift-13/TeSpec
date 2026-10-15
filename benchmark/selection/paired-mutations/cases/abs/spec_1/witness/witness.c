#include <stdio.h>
#include <limits.h>
int abs(int x)

{ if (x >= 0) { return x; } else { return -x; } }
int main(void) { long long result = abs(-2); printf("%lld\n",result); return 0; }
