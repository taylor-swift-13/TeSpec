/*@
function [rec] (integer) AllPositive(map<integer,integer> a, integer n) { if(n < 1) {1} else { if(a[n-1] > 0) {AllPositive(a,n-1)} else {0} } }
@*/
int array_all_positive(int n, int *a)
/*@ requires 0 <= n; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; B == A; (return == 1 && AllPositive(A,n) == 1) || (return == 0 && AllPositive(A,n) == 0); @*/
{
    int i;

    for (i = 0; i < n; ++i) {
        if (a[i] < 0) {
            return 0;
        }
    }

    return 1;
}
