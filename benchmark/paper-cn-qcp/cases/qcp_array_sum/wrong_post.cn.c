/*@
function [rec] (integer) Sum(map<integer,integer> a, integer n) {
 if(n <= 0) {0} else { a[n-1] + Sum(a,n-1) }
}
@*/
int arr_sum(int n, int *a)
/*@ requires 0 < n; n < 100; take A = each(integer k; 0 <= k && k < n) {RW<int>(array_shift<int>(a,k))}; each (integer k; 0 <= k && k < n) {0 <= A[k] && A[k] < 100}; ensures take B = each(integer k; 0 <= k && k < n) {RW<int>(array_shift<int>(a,k))}; return == Sum(A,n)+1; B == A; @*/
{
  int i;
  i = 0;
  int ret;
  ret = 0;
  
  while (i < n) {
    ret += a[i];
    ++i;
  }
  return ret;
}
