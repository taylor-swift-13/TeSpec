#include <stdio.h>
#include <limits.h>
int read(int *p)

{ return *p; }
int main(void) { int cell = 7; long long result = read(&cell); printf("%lld %lld\n",result,(long long)cell); return 0; }
