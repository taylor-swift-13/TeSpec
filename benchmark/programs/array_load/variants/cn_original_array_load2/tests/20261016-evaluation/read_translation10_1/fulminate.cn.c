int read (int *p, int n, int i)
/*@ requires take a1 = each(i32 j; 0i32 <= j && j < n) { Owned<int>(array_shift<int>(p,j)) };
             0i32 <= i && i < n;
    ensures take a2 = each(i32 j; 0i32 <= j && j < n) { Owned<int>(array_shift<int>(p,j)) };
            a1 == a2;
            return == a1[i];
@*/
{
  /*@ extract Owned<int>, i; @*/
  return p[i];
}

int main(void) /*@ ensures return == 0i32; @*/ { int a[1]={(-2147483648)}; int result=read(a,1,0); (void)result; return 0; }
