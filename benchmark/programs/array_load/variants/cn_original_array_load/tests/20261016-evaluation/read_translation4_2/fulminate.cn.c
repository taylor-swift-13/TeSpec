int read (int *p, int n, int i)
/*@ requires take a1 = each(i32 j; 0i32 <= j && j < n) { 
                          Owned<int>(array_shift<int>(p,j)) };
             0i32 <= i && i < n;
    ensures take a2 = each(i32 j; 0i32 <= j && j < n) { 
                            Owned<int>(array_shift<int>(p,j)) }; @*/
{
  /*@ extract Owned<int>, i; @*/
  return p[i];
}

int main(void) /*@ ensures return == 0i32; @*/ { int a[2]={(2147483647),(-1)}; int result=read(a,2,1); (void)result; return 0; }
