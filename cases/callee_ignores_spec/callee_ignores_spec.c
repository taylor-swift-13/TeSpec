int misleading_callee(int n)
/*@ With (claimed: Z)
    Require n == 0 && emp
    Ensure __return == claimed && emp
*/
{
    return n + 1;
}

int callee_ignores_spec(int n)
/*@ With (N: Z)
    Require n == N && 0 <= N && N < INT_MAX && emp
    Ensure __return == N + 1 && emp
*/
{
    return misleading_callee(n);
}
