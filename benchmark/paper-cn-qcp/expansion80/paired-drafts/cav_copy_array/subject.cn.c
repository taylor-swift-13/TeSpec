void copy_array(int n, int *src, int *dst)
/*@ requires 0 <= n; take U = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(src,i))}; take V = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(dst,i))}; ensures take U2 = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(src,i))}; take V2 = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(dst,i))}; U2 == U; V2 == U; @*/
{
    int i;

    for (i = 0; i < n; ++i) {
        dst[i] = src[i];
    }
}
