int invalid_binding(void)
/*@ With (x: Z)
    Require x == 1 && emp
    Ensure __return == x && emp
 */
{
  return 1;
}
