/*@
function [rec] (integer) Sum(map<integer,integer> a, integer n) { if(n <= 0) {0} else {a[n-1] + Sum(a,n-1)} }
@*/
int array_sum(int n, int *a)
/*@ requires 0 <= n; n <= 10000; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; each(integer i; 0 <= i && i < n) {-10000 <= A[i] && A[i] <= 10000}; -2147483648 <= Sum(A,n); Sum(A,n) <= 2147483647; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; B == A; return == Sum(A,n); @*/
{
    int i;
    int ret = 0;

    for (i = 0; i < n; ++i) {
        ret -= a[i];
    }

    return ret;
}
