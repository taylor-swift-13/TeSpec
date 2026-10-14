int add(int x, int y)
  /*@ Require
        0 <= x && x <= 100 && 
        0 <= y && y <= 100 && emp
      Ensure
        __return == x + y + 1 && emp
   */
{
  int z;
  z = x + y;
  return z;
}
