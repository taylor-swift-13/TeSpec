#include "verification_stdlib.h"

/*@ Extern Coq (UIntArray::full : Z -> Z -> list Z -> Assertion) (UIntArray::missing_i : Z -> Z -> Z -> Z -> list Z -> Assertion) (Znth : {A} -> Z -> list A -> A -> A) */
/*@ include strategies "/home/yangfp/teSpec/benchmark/programs/add_two_array/variants/qcp_existing_5736a18fda591af6509c/qcp/uint_array.strategies" */

unsigned int array_read_two (unsigned int *p, int n, int i, int j)

/*@ __tespec_entry With (l: list Z) Require
      (p == (4096)) && (n == (2)) && (i == (1)) && (j == (0)) && (l == (cons(4294967295, cons(4294967295, nil)))) && 0 <= i && i < n && 0 <= j && j < n && i != j && 0 <= Znth(i,l,0) && Znth(i,l,0) <= 4294967295 && 0 <= Znth(j,l,0) && Znth(j,l,0) <= 4294967295 && UIntArray::full(p,n,l) Ensure __return == (Znth(i,l,0)+Znth(j,l,0))%4294967296 && UIntArray::full(p,n,l) */
/*@ With (l: list Z) Require 0 <= i && i < n && 0 <= j && j < n && i != j && 0 <= Znth(i,l,0) && Znth(i,l,0) <= 4294967295 && 0 <= Znth(j,l,0) && Znth(j,l,0) <= 4294967295 && UIntArray::full(p,n,l) Ensure __return == (Znth(i,l,0)+Znth(j,l,0))%4294967296 && UIntArray::full(p,n,l) */
{
  unsigned int tmp1 = p[i];
  unsigned int tmp2 = p[j];
  return (tmp1 + tmp2);
}
