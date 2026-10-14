/*@
function [rec] (integer) Min(map<integer,integer> a, integer n) { if(n <= 1) {a[0]} else { if(a[n-1] < Min(a,n-1)) {a[n-1]} else {Min(a,n-1)} } }
@*/
int array_min(int n, int *a)
/*@ requires 1 <= n; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; B == A; return == Min(A,n); @*/
{
    int i;
    int ret = a[0];

    for (i = 1; i < n; ++i) {
        if (a[i] > ret) {
            ret = a[i];
        }
    }

    return ret;
}
