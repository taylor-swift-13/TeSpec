

int is_even(int n)
/*@ requires true; ensures (rem(n, 2) != 0 || return == 1) && (rem(n, 2) == 0 || return == 0); @*/
{
    return n % 2 != 0;
}
