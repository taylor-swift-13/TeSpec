int read (int *p, int n, int i)
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

int main()
{
    int a[3] = { 0, 1, 2 };

    int zero = read(a, 3, 0);
    /*@ assert (zero == 0); @*/
    int *first = a;
    /*@ assert (*first == 0); @*/

    int one = read(a, 3, 1);
    /*@ assert (one == 1); @*/
    int *second = a + 1;
    /*@ assert (*second == 1); @*/

    int two = read(a, 3, 2);
    /*@ assert (two == 2); @*/
    int *third = a + 2;
    /*@ assert (*third == 2); @*/
}
