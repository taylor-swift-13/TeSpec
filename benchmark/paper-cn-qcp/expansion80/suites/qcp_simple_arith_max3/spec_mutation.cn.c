

int max3(int x, int y, int z)
  /*@ requires -2147483648 <= x; x <= 2147483647; -2147483648 <= y; y <= 2147483647; -2147483648 <= z; z <= 2147483647; ensures return > x; return >= y; return >= z; @*/
{
  if (x < y)
    if (y < z)
      return z;
    else
      return y;
  else
    if (x < z)
      return z;
    else
      return x;
}
