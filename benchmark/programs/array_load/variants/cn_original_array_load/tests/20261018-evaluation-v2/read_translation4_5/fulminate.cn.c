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

int main(void) /*@ ensures return == 0; @*/ { int a[4]={(-7),(0),(7),(12)}; int result=array_load_read(a,4,1); (void)result; return 0; }
