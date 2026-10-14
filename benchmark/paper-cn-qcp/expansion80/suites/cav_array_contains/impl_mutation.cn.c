/*@
function [rec] (integer) Contains(map<integer,integer> a, integer n, integer k) { if(n < 1) {0} else { if(a[n-1] == k) {1} else {Contains(a,n-1,k)} } }
@*/
int array_contains(int n, int *a, int k)
/*@ requires 0 <= n; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; B == A; (return == 1 && Contains(A,n,k) == 1) || (return == 0 && Contains(A,n,k) == 0); @*/
{
    int i;

    for (i = 0; i < n; ++i) {
        if (a[i] != k) {
            return 1;
        }
    }

    return 0;
}
