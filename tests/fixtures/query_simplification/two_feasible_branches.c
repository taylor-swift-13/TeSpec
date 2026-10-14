int sample(int *p)
/*@ Require exists x, 0 <= x && x <= 1 && data_at(p, int, x)
    Ensure exists x, __return == x && data_at(p, int, x) */
{
    int v = *p;
    if (v == 0) return 0;
    else return 1;
}
