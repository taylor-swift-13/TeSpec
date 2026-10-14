int algo_string_length(char *s)
/*@ requires cn_ghost integer n; 0 <= n; n < 2147483647; take A = each(integer i; 0 <= i && i <= n) {RW<char>(array_shift<char>(s,i))}; A[n] == 0; each(integer k; 0 <= k && k < n) {A[k] != 0}; ensures take B = each(integer i; 0 <= i && i <= n) {RW<char>(array_shift<char>(s,i))}; B == A; return == n + 1; @*/
{
    int i = 0;

    while (1) {
        if (s[i] == 0) {
            break;
        }
        i++;
    }

    return i;
}
