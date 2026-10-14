

int max_of_three(int a, int b, int c)
/*@ requires true; ensures (return == a || return == b || return == c) && a <= return && b <= return && c <= return; @*/
{
    int m = a;

    if (b > m) {
        m = b;
    }
    if (c > m) {
        m = c;
    }

    return a;
}
