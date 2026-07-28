void increment_in_callee(int *p, int n)
{
    while (n > 0) {
        *p = *p + 1;
        n--;
    }
}

int callee_heap(int *p, int n)
/*@ With (v: Z) (N: Z)
    Require n == N && 0 <= N && v + N <= INT_MAX &&
            data_at(p, int, v)
    Ensure __return == v + N && data_at(p@pre, int, v + N)
*/
{
    increment_in_callee(p, n);
    return *p;
}
