#include "verification_stdlib.h"
#include "int_array_def.h"

int read (int *p, int n, int i)
/*@ With (l: list Z) Require 0 <= i && i < n && IntArray::full(p,n,l) Ensure __return == Znth(i,l,0) && IntArray::full(p,n,l) */
{
  return p[i];
}
