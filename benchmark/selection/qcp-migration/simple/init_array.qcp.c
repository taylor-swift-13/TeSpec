#include "verification_stdlib.h"
#include "char_array_def.h"

void init_array (char *p, unsigned int n)
/*@ With (l: list Z) Require 0 <= n && n <= 4294967295 && CharArray::full(p,n,l) Ensure exists (l2: list Z), CharArray::full(p,n,l2) */
{
  unsigned int j;
  j = 0;
  /*@ Inv exists (li: list Z), 0 <= j && j <= n@pre && CharArray::full(p@pre,n@pre,li) */
  while (j < n)
  {
    p[j] = 0;
    j++;
  }
}
