#include <stdio.h>
#include <limits.h>
unsigned int example_let(unsigned int n)

{ return n; }
int main(void) { long long result = example_let(2); printf("%lld\n",result); return 0; }
