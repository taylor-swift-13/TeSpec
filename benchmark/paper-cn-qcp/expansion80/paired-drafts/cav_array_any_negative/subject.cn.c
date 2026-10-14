/*@
function [rec] (integer) AnyNegative(map<integer,integer> a, integer n) { if(n < 1) {0} else { if(a[n-1] < 0) {1} else {AnyNegative(a,n-1)} } }
@*/
int array_any_negative(int n, int *a)
/*@ requires 0 <= n; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; B == A; (return == 1 && AnyNegative(A,n) == 1) || (return == 0 && AnyNegative(A,n) == 0); @*/
{
    int i;

    for (i = 0; i < n; ++i) {
        if (a[i] < 0) {
            return 1;
        }
    }

    return 0;
}
