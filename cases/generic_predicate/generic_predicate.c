struct cell {
  int value;
};

/*@ Let cell_at(p: Z, x: Z) =
      p != 0 &&
      data_at(field_addr(p, cell, value), int, x)
 */

int read_custom(struct cell *p)
/*@ With (v: Z)
    Require (v == 7) && cell_at(p, v)
    Ensure __return == v && cell_at(p@pre, v)
 */
{
  return p->value;
}
