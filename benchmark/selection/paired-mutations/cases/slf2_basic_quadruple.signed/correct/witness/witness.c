#include <stdio.h>
#include <limits.h>
int quadruple(int n)

{ int m = n+n; return m+m; }
int main(void) { long long result = quadruple(2); printf("%lld\n",result); return 0; }
