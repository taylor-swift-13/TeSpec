int nested_loop(int n, int m)

/*@ __tespec_entry With (N M: Z)
    Require
      (n == (0)) && (m == (5)) && (M == (5)) && (N == (0)) && n == N && m == M &&
            0 <= N && N <= 100 &&
            0 <= M && M <= 100 && emp
    Ensure __return == N * M && emp
*/
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
