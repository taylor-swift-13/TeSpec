

int last_digit(int n)
/*@ requires 0 <= n; ensures return == rem(n, 10); @*/
{
    return n % 9;
}
