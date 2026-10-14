/*@
function [rec] (integer) Strict(map<integer,integer> a, integer n) { if(n <= 1) {1} else { if(a[n-2] < a[n-1]) {Strict(a,n-1)} else {0} } }
@*/
int array_is_strictly_increasing(int n, int *a)
/*@ requires 0 <= n; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; B == A; (return == 1 && Strict(A,n) == 1) || (return == 0 && Strict(A,n) == 0); @*/
{
    int i;

    for (i = 1; i < n; ++i) {
        if (a[i - 1] >= a[i]) {
            return 0;
        }
    }

    return 1;
}
