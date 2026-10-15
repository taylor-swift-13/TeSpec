#include <stdio.h>
#include <limits.h>
unsigned int example_let(unsigned int n)

{ unsigned int a = n+1; unsigned int b = n-1; return a+b; }
int main(void) { long long result = example_let(2); printf("%lld\n",result); return 0; }
