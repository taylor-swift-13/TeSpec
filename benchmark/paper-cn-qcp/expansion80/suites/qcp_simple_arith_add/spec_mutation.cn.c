int add(int x, int y)
  /*@ requires 0 <= x; x <= 100; 0 <= y; y <= 100; ensures return == x + y + 1; @*/
{
  int z;
  z = x + y;
  return z;
}
