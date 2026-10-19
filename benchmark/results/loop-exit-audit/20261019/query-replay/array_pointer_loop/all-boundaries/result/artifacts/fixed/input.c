int sample(int *p)

/*@ __tespec_entry With l Require
      (p == (4096)) && (l == (cons(2, cons(4, cons(6, nil))))) && IntArray::full(p, 3, l)
    Ensure __return == 12 && IntArray::full(p, 3, l) */
/*@ With l Require IntArray::full(p, 3, l)
    Ensure __return == 12 && IntArray::full(p, 3, l) */
{
    int i = 0, total = 0;
    int *end = p + 3;
    while (end - (p + i) != 0) { total += p[i]; i++; }
    return total;
}
