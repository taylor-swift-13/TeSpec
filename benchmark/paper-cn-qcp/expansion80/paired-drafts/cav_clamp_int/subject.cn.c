int clamp_int(int x, int lo, int hi)
/*@ requires lo <= hi; ensures (x >= lo || return == lo) && (x <= hi || return == hi) && (x < lo || x > hi || return == x); @*/
{
    if (x < lo) {
        return lo;
    }
    if (x > hi) {
        return hi;
    }
    return x;
}
