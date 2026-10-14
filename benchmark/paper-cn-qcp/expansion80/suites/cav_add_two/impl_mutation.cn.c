

int add_two(int a, int b)
/*@ requires  -2147483648 <= a + b; a + b <= 2147483647; ensures return == a + b; @*/
{
    return a;
}
