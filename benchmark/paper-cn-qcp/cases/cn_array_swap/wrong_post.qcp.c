#include "verification_stdlib.h"
#include "int_array_def.h"
void array_swap (int *p, int n, int i, int j)
/*@ With (l: list Z) Require 0 <= i && i < n && 0 <= j && j < n && j != i && IntArray::full(p,n,l) Ensure IntArray::full(p,n,l) */
{

  
  

  int tmp = p[i];

  
  

  p[i] = p[j];
  p[j] = tmp;
}
