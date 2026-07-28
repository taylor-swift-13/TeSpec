int factorial_body(int n)
{
    if (n <= 1) {
        return 1;
    }
    return n * factorial_body(n - 1);
}

int callee_recursive(int n)
/*@ With (N: Z) (expected: Z)
    Require n == N && 0 <= N && N <= 10 && emp
    Ensure __return == expected && emp
*/
{
    return factorial_body(n);
}
