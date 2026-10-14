

int min_of_three(int a, int b, int c)
/*@ requires true; ensures (return == a || return == b || return == c) && return <= a && return <= b && return <= c; @*/
{
    int m = a;

    if (b < m) {
        m = b;
    }
    if (c < m) {
        m = c;
    }

    return m;
}
