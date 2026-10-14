char string_first_char(char *s)
/*@ requires cn_ghost integer n; 1 <= n; n < 2147483647; take S = each(integer i; 0 <= i && i <= n) {RW<char>(array_shift<char>(s,i))}; S[n] == 0; each(integer i; 0 <= i && i < n) {S[i] != 0}; ensures take T = each(integer i; 0 <= i && i <= n) {RW<char>(array_shift<char>(s,i))}; T == S; return == S[0] + 1; @*/
{
    return s[0];
}
