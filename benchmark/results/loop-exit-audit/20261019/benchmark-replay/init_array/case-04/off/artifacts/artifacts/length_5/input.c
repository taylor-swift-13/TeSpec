#include "verification_stdlib.h"
#include "char_array_def.h"

void init_array (char *p, unsigned int n)

/*@ __tespec_entry With (l: list Z) Require
      (p == (4096)) && (n == (5)) && (l == (cons(127, cons(40, cons(81, cons(122, cons(35, nil))))))) && 0 <= n && n <= 4294967295 && CharArray::full(p,n,l) Ensure exists (l2: list Z), CharArray::full(p,n,l2) */
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
