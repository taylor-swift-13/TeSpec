void string_to_upper_ascii(char *s)
/*@ requires cn_ghost integer n; 0 <= n; n < 2147483647; take A = each(integer i; 0 <= i && i <= n) {RW<char>(array_shift<char>(s,i))}; A[n] == 0; each(integer k; 0 <= k && k < n) {A[k] != 0}; ensures take B = each(integer i; 0 <= i && i <= n) {RW<char>(array_shift<char>(s,i))}; B[n] == 0; each(integer k; 0 <= k && k < n) {B[k] != 0}; each(integer i; 0 <= i && i < n) {(A[i] < 97 || 122 < A[i] || B[i] == A[i] - 32) && ((97 <= A[i] && A[i] <= 122) || B[i] == A[i])}; @*/
{
    int i = 0;

    while (1) {
        if (s[i] == 0) {
            break;
        }
        if (s[i] >= 97 && s[i] <= 122) {
            s[i] = s[i] - 31;
        }
        i++;
    }
}
