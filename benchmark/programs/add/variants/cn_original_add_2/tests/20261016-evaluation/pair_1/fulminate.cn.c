int add(int x, int y)
/* --BEGIN-- */
/*@ requires let sum = (i64) x + (i64) y;
             (i64)MINi32() <= sum; sum <= (i64)MAXi32();
    ensures return == (i32) sum;
@*/
/* --END-- */
{
  return x+y;
}
int main(void) /*@ ensures return == 0i32; @*/ { add(1, 0); return 0; }
