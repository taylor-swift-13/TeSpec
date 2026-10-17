int array_load_read (int *p, int n, int i)
/*@ requires take a1 = each(integer j; 0 <= j && j < n) { 
                          RW<int>(array_shift<int>(p,j)) };
             0 <= i && i < n;
    ensures take a2 = each(integer j; 0 <= j && j < n) { 
                            RW<int>(array_shift<int>(p,j)) }; @*/
{
  /*@ focus RW<int>, i; @*/
  return p[i];
}

int main(void) /*@ ensures return == 0i32; @*/ { int a[1]={(-2147483648)}; int result=array_load_read(a,1,0); (void)result; return 0; }
