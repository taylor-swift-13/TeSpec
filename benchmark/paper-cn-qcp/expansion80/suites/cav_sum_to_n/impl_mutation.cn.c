

int sum_to_n(int n)
/*@ requires 0 <= n; -2147483648 <= n * (n + 1) / 2; n * (n + 1) / 2 <= 2147483647; ensures return == n * (n + 1) / 2; @*/
{
    int i;
    int ret = 0;

    for (i = 1; i <= n; ++i) {
        ret += i - 1;
    }

    return ret;
}
