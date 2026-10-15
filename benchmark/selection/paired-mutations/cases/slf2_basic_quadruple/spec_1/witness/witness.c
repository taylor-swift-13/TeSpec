#include <stdio.h>
#include <limits.h>
unsigned int quadruple(unsigned int n)

{ unsigned int m = n+n; return m+m; }
int main(void) { long long result = quadruple(2); printf("%lld\n",result); return 0; }
