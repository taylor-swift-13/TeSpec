char string_last_char(char *s)
/*@ requires cn_ghost integer n; 1 <= n; n < 2147483647; take S = each(integer i; 0 <= i && i <= n) {RW<char>(array_shift<char>(s,i))}; S[n] == 0; each(integer i; 0 <= i && i < n) {S[i] != 0}; ensures take T = each(integer i; 0 <= i && i <= n) {RW<char>(array_shift<char>(s,i))}; T == S; return == S[n-1]; @*/
{
    int i = 0;

    while (1) {
        if (s[i + 1] == 0) {
            break;
        }
        i++;
    }

    return s[i];
}
