#include "verification_stdlib.h"
#include "char_array_def.h"

void init_array2 (char *p, unsigned int n)

/*@ __tespec_entry Require
      (p == (4096)) && (n == (0)) && 0 <= n && n <= 4294967295 && CharArray::undef_full(p,n) Ensure exists (l2: list Z), CharArray::full(p,n,l2) */
/*@ Require 0 <= n && n <= 4294967295 && CharArray::undef_full(p,n) Ensure exists (l2: list Z), CharArray::full(p,n,l2) */
{
  unsigned int j;
  j = 0;
  /*@ Inv 0 <= j && j <= n@pre && CharArray::full(p@pre,j,repeat_Z(0,j)) * CharArray::undef_seg(p@pre,j,n@pre) */
  while (j < n)
  {
    p[j] = 0;
    j++;
  }
}
