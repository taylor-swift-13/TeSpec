void string_reverse_copy(int n, char *src, char *dst)
/*@ requires 0 <= n; n < 2147483647; take S = each(integer i; 0 <= i && i <= n) {RW<char>(array_shift<char>(src,i))}; take D = each(integer i; 0 <= i && i <= n) {RW<char>(array_shift<char>(dst,i))}; S[n] == 0; each(integer i; 0 <= i && i < n) {S[i] != 0}; ensures take S2 = each(integer i; 0 <= i && i <= n) {RW<char>(array_shift<char>(src,i))}; take D2 = each(integer i; 0 <= i && i <= n) {RW<char>(array_shift<char>(dst,i))}; S2 == S; D2[n] == 0; each(integer i; 0 <= i && i < n) {D2[i] == S[i]}; @*/
{
    int i;

    for (i = 0; i < n; ++i) {
        dst[i] = src[n - 1 - i];
    }
    dst[n] = 0;
}
