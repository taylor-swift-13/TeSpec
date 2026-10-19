#include "verification_stdlib.h"
#include "char_array_def.h"
/*@ include strategies "/home/yangfp/teSpec/benchmark/selection/qcp-migration/simple/init_array_rev.strategies" */

void init_array2 (char *p, unsigned int n)

/*@ __tespec_entry Require
      (p == (4096)) && (n == (8)) && 0 <= n && n <= 4294967295 && 0 < n && CharArray::undef_full(p,n) Ensure exists (l2: list Z), CharArray::full(p,n,l2) */
/*@ Require 0 <= n && n <= 4294967295 && 0 < n && CharArray::undef_full(p,n) Ensure exists (l2: list Z), CharArray::full(p,n,l2) */
{
  unsigned int j;
  j= 0;
  /*@ Inv 0 <= j && j <= n@pre && CharArray::undef_seg(p@pre,0,n@pre-j) * CharArray::seg(p@pre,n@pre-j,n@pre,repeat_Z(0,j)) */
  while (j < n)
  {
    p[n-(j+1)] = 0;
    j++;
  }
}
