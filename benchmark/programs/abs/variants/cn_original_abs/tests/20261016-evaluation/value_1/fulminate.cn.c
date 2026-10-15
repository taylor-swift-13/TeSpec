int abs (int x)
/* --BEGIN-- */
/*@ requires MINi32() < x;
    ensures return == ((x >= 0i32) ? x : (0i32-x));
@*/
/* --END-- */
{
  if (x >= 0) {
    return x;
  }
  else {
    return -x;
  }
}
int main(void) /*@ ensures return == 0i32; @*/ { abs(-7); return 0; }
