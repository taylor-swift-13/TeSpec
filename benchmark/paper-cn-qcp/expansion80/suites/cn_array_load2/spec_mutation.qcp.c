#include "verification_stdlib.h"
#include "int_array_def.h"
int read (int *p, int n, int i)
/*@ With l Require 0 <= i && i < n && Zlength(l) == n && IntArray::full(p,n,l) Ensure __return == l[i] + 1 && IntArray::full(p,n,l) */
{
  
  
  return p[i];
}
