int nested_loop(int n, int m)
/*@ With (N M: Z)
    Require n == N && m == M &&
            0 <= N && N <= 100 &&
            0 <= M && M <= 100 && emp
    Ensure __return == N * M && emp
*/
{
    int count = 0;
    int i;
    int j;
    for (i = 0; i < n; i++) {
        for (j = 0; j < m; j++) {
            count++;
        }
    }
    return count;
}
