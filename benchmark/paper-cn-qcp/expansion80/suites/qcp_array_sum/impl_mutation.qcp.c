#include "verification_stdlib.h"
#include "int_array_def.h"
int arr_sum(int n, int *a)
/*@ With (l: list Z) Require 0 < n && n < 100 && (forall (k: Z), (0 <= k && k < n) => (0 <= l[k] && l[k] < 100)) && IntArray::full(a,n,l) Ensure __return == sum(l) && IntArray::full(a,n,l) */
{
  int i;
  i = 0;
  int ret;
  ret = 0;
  
  while (i < n) {
    ret -= a[i];
    ++i;
  }
  return ret;
}
