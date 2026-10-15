unsigned int quadruple (unsigned int n)
/*@ ensures return == 4u32 * n; @*/
{
  unsigned int m = n + n;
  return m + m;
}
int main(void) /*@ ensures return == 0i32; @*/ { quadruple(4294967294u); return 0; }
