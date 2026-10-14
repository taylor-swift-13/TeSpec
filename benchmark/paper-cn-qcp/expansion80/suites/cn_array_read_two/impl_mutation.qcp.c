#include "verification_stdlib.h"
#include "int_array_def.h"
unsigned int array_read_two (unsigned int *p, int n, int i, int j)
/* --BEGIN-- */
/*@ With l Require 0 <= i && i < n && 0 <= j && j < n && i != j && Zlength(l) == n && l[i] + l[j] <= 4294967295 && UIntArray::full(p,n,l) Ensure __return == l[i] + l[j] && UIntArray::full(p,n,l) */
/* --END-- */
{
/* --BEGIN-- */
  
  
/* --END-- */
  unsigned int tmp1 = p[i];
/* --BEGIN-- */
  
  
/* --END-- */
  unsigned int tmp2 = p[j];
  return tmp1;
}
