/*@
function [rec] (integer) Sum(map<integer,integer> a, integer n) {
 if(n <= 0) {0} else { a[n-1] + Sum(a,n-1) }
}
@*/
int arr_sum_update(int n, int *a)
/*@ requires 0 < n; n < 100; take A = each(integer k; 0 <= k && k < n) {RW<int>(array_shift<int>(a,k))}; each (integer k; 0 <= k && k < n) {0 <= A[k] && A[k] < 100}; ensures take B = each(integer k; 0 <= k && k < n) {RW<int>(array_shift<int>(a,k))}; return == Sum(A,n)+1; each(integer k; 0 <= k && k < n) {B[k] == 0}; @*/
{
  int i;
  int ret = 0;
  
  for (i = 0; i < n; ++i) {
    
    ret += a[i];
    a[i] = 0;
  }
  return ret;
}
