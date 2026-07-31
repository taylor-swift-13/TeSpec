void increment_cell(int *p)
/*@ With (v: Z)
    Require v < 2147483647 && data_at(p, int, v)
    Ensure data_at(p@pre, int, v + 1)
*/
{
    *p = *p + 1;
}
