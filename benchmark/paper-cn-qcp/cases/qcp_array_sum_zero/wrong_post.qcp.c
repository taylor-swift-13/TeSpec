#include "verification_stdlib.h"
#include "int_array_def.h"
int arr_sum_update(int n, int *a)
/*@ With (l: list Z) Require 0 < n && n < 100 && (forall (k: Z), (0 <= k && k < n) => (0 <= l[k] && l[k] < 100)) && IntArray::full(a,n,l) Ensure __return == sum(l)+1 && IntArray::full(a,n,zeros(n)) */
{
  int i;
  int ret = 0;
  
  for (i = 0; i < n; ++i) {
    
    ret += a[i];
    a[i] = 0;
  }
  return ret;
}
