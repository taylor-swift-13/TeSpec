#include <limits.h>
void incr (int *p)
{
  *p = *p+1;
}
int main(void){int x=INT_MAX;incr(&x);return 0;}
