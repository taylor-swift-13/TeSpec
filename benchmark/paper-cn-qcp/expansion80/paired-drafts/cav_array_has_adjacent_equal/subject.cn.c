/*@
function [rec] (integer) AdjacentEqual(map<integer,integer> a, integer n) { if(n < 2) {0} else { if(a[n-1] == a[n-2]) {1} else {AdjacentEqual(a,n-1)} } }
@*/
int array_has_adjacent_equal(int n, int *a)
/*@ requires 0 <= n; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; B == A; (return == 1 && AdjacentEqual(A,n) == 1) || (return == 0 && AdjacentEqual(A,n) == 0); @*/
{
    int i;

    for (i = 1; i < n; ++i) {
        if (a[i] == a[i - 1]) {
            return 1;
        }
    }

    return 0;
}
