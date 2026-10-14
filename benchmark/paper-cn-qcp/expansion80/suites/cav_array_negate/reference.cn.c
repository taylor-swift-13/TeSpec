void array_negate(int n, int *a, int *out)
/*@ requires 0 <= n; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))};take O = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(out,i))}; each(integer i; 0 <= i && i < n) {-2147483648 <= -A[i] && -A[i] <= 2147483647}; ensures take A2 = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))};take O2 = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(out,i))}; A2 == A; each(integer i; 0 <= i && i < n) {O2[i] == -A[i]}; @*/
{
    int i;

    for (i = 0; i < n; ++i) {
        out[i] = -a[i];
    }
}
