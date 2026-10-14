

int last_digit(int n)
/*@ requires 0 <= n; ensures return == rem(n, 9); @*/
{
    return n % 10;
}
