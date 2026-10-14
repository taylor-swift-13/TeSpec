#include "verification_stdlib.h"
int bench_abs(int x)
/*@ Require -2147483648 < x && emp Ensure ((__return == x + 1 && x >= 0) || (__return == -x + 1 && x < 0)) && emp */
{
  if (x >= 0) {
    return x;
  } else {
    return -x;
  }
}
