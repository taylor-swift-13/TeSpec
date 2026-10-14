void array_increment(int n, int *a)
/*@ requires 0 <= n; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; each(integer i; 0 <= i && i < n) {-2147483648 <= A[i] + 1 && A[i] + 1 <= 2147483647}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; each(integer i; 0 <= i && i < n) {B[i] == A[i] + 1}; @*/
{
    int i;

    for (i = 0; i < n; ++i) {
        a[i] = a[i] + 1;
    }
}
