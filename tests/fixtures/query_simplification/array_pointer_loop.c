int sample(int *p)
/*@ With l Require IntArray::full(p, 3, l)
    Ensure __return == 12 && IntArray::full(p, 3, l) */
{
    int i = 0, total = 0;
    int *end = p + 3;
    while (end - (p + i) != 0) { total += p[i]; i++; }
    return total;
}
