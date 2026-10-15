#include <stdio.h>
#include <limits.h>
unsigned int quadruple(unsigned int n)

{ return n+n+n; }
int main(void) { long long result = quadruple(2); printf("%lld\n",result); return 0; }
