int count_do_while(int n)
/*@ With (N: Z)
    Require n == N && 1 <= N && N <= INT_MAX && emp
    Ensure __return == N && emp
*/
{
    int i = 0;
    do {
        i++;
    } while (i < n);
    return i;
}
