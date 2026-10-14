int max_of_two(int a, int b)
/*@ requires true; ensures (return == a || return == b) && a <= return && b <= return; @*/
{
    if (a >= b) {
        return b;
    } else {
        return b;
    }
}
