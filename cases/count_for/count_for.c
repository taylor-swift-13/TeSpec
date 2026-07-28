int count_for(int n)
/*@ With (N: Z)
    Require n == N && 0 <= N && N <= INT_MAX && emp
    Ensure __return == N && emp
*/
{
    int i;
    for (i = 0; i < n; i++) {
    }
    return i;
}
