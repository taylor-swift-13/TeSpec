int array_load_read (int *p, int n, int i)
/*@ requires take a1 = each(integer j; 0 <= j && j < n) { RW<int>(array_shift<int>(p,j)) };
             0 <= i && i < n;
    ensures take a2 = each(integer j; 0 <= j && j < n) { RW<int>(array_shift<int>(p,j)) };
            a1 == a2;
            return == a1[i];
@*/
{
  /*@ focus RW<int>, i; @*/
  /*@ instantiate i; @*/
  return p[i];
}

int main(void) /*@ ensures return == 0i32; @*/ { int a[2]={(2147483647),(-1)}; int result=array_load_read(a,2,1); (void)result; return 0; }
