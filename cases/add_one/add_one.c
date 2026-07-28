int add_one(int x)
/*@ With (v: Z)
    Require x == v && v < 2147483647
    Ensure __return == v + 1
*/
{
  return x + 1;
}
