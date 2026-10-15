#include "verification_stdlib.h"

#include "int_array_def.h"

int read (int *p, int n, int i)
/*@ With (l: list Z) Require 0 <= i && i < n && IntArray::full(p,n,l) Ensure exists l2, IntArray::full(p,n,l2) */
{
  return p[i];
}
