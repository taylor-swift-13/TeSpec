#include "verification_stdlib.h"
#include "int_array_def.h"

int read (int *p, int n, int i)

/*@ __tespec_entry With (l: list Z) Require
      (p == (4096)) && (n == (1)) && (i == (0)) && (l == (cons(0, nil))) && 0 <= i && i < n && IntArray::full(p,n,l) Ensure exists l2, IntArray::full(p,n,l2) */
/*@ With (l: list Z) Require 0 <= i && i < n && IntArray::full(p,n,l) Ensure exists l2, IntArray::full(p,n,l2) */
{
  return p[i];
}
