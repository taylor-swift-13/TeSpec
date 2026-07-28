int read_cell(int *p)
/*@ With (v: Z)
    Require data_at(p, int, v)
    Ensure __return == v && data_at(p@pre, int, v)
*/
{
  return *p;
}
