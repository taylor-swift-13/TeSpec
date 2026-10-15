#include <limits.h>
void incr (int *p)
{
  int n = *p;
  int m = n+1;
  *p = m;
}
int main(void){int x=INT_MAX;incr(&x);return 0;}
