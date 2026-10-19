#include "verification_stdlib.h"
#include "int_array_def.h"

void swap_array (int *p, int n, int i, int j)

/*@ __tespec_entry With (l: list Z) Require
      (p == (4096)) && (n == (2)) && (i == (1)) && (j == (0)) && (l == (cons(1, cons(-1, nil)))) && 0 <= i && i < n && 0 <= j && j < n && i != j && IntArray::full(p,n,l) Ensure IntArray::full(p,n,replace_Znth(j,Znth(i,l,0),replace_Znth(i,Znth(j,l,0),l))) */
/*@ With (l: list Z) Require 0 <= i && i < n && 0 <= j && j < n && i != j && IntArray::full(p,n,l) Ensure IntArray::full(p,n,replace_Znth(j,Znth(i,l,0),replace_Znth(i,Znth(j,l,0),l))) */
{
  int tmp = p[i];
  p[i] = p[j];
  p[j] = tmp;
}
