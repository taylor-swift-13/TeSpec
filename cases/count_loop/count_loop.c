int count_loop(int n)
/*@ With (N: Z)
    Require n == N && 0 <= N && N <= INT_MAX && emp
    Ensure __return == N && emp
*/
{
    int i = 0;
    while (i < n) {
        i++;
    }
    return i;
}
