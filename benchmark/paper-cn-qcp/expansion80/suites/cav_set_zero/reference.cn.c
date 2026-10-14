void set_zero(int n, int *a)
/*@ requires 0 <= n; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; each(integer i; 0 <= i && i < n) {B[i] == 0}; @*/
{
    int i;

    for (i = 0; i < n; ++i) {
        a[i] = 0;
    }
}
