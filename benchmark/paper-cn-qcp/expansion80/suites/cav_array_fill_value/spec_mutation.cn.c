void array_fill_value(int n, int k, int *a)
/*@ requires 0 <= n; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; each(integer i; 0 <= i && i < n) {B[i] == k + 1}; @*/
{
    int i = 0;
    while (i < n) {
        a[i] = k;
        i++;
    }
}
