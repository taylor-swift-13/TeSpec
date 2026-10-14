/*@
function [rec] (integer) Nonzero(map<integer,integer> a, integer n) { if(n <= 0) {0} else { if(a[n-1] != 0) {1 + Nonzero(a,n-1)} else {Nonzero(a,n-1)} } }
@*/
int array_count_nonzero(int n, int *a)
/*@ requires 0 <= n; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; B == A; return == Nonzero(A,n); @*/
{
    int i;
    int count = 0;

    for (i = 0; i < n; ++i) {
        if (a[i] != 0) {
            count++;
        }
    }

    return count;
}
