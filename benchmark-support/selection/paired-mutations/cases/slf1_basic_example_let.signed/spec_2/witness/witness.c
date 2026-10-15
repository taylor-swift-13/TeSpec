#include <stdio.h>
#include <limits.h>
int doubled(int n)

{ int a = n+1; int b = n-1; return a+b; }
int main(void) { long long result = doubled(2); printf("%lld\n",result); return 0; }
