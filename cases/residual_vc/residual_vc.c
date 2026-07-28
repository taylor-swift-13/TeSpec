int residual_vc(void)
/*@ Require emp
    Ensure (forall (x: Z), x == x) && __return == 0 && emp
*/
{
  return 0;
}
