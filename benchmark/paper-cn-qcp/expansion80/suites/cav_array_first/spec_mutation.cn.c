int array_first(int n, int *a)
/*@ requires 1 <= n; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; return == A[0] + 1; B == A; @*/
{
    return a[0];
}
