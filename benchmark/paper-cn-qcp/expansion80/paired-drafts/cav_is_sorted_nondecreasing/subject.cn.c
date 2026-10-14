/*@
function [rec] (integer) Sorted(map<integer,integer> a, integer n) { if(n < 2) {1} else { if(a[n-2] <= a[n-1]) {Sorted(a,n-1)} else {0} } }
@*/
int is_sorted_nondecreasing(int n, int *a)
/*@ requires 0 <= n; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; B == A; (return == 1 && Sorted(A,n) == 1) || (return == 0 && Sorted(A,n) == 0); @*/
{
    int i;

    for (i = 0; i + 1 < n; ++i) {
        if (a[i] > a[i + 1]) {
            return 0;
        }
    }

    return 1;
}
