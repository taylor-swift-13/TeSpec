#include "verification_stdlib.h"


#include "int_array_def.h"

int read (int *p, int n, int i)

/*@ __tespec_entry With (l: list Z) Require
      (p == (4096)) && (n == (2)) && (i == (1)) && (l == (cons(2147483647, cons(-1, nil)))) && 0 <= i && i < n && IntArray::full(p,n,l) Ensure __return == Znth(i,l,0) && IntArray::full(p,n,l) */
/*@ With (l: list Z) Require 0 <= i && i < n && IntArray::full(p,n,l) Ensure __return == Znth(i,l,0) && IntArray::full(p,n,l) */
{
  return p[i];
}

int main()
/*@ Require emp Ensure __return == 0 && emp */
{
    int a[3] = { 0, 1, 2 };
    int zero = read(a, 3, 0);
/*@ Assert zero == 0 */
    int *first = a;
/*@ Assert data_at(first,int,0) */
    int one = read(a, 3, 1);
/*@ Assert one == 1 */
    int *second = a + 1;
/*@ Assert data_at(second,int,1) */
    int two = read(a, 3, 2);
/*@ Assert two == 2 */
    int *third = a + 2;
/*@ Assert data_at(third,int,2) */
  return 0;
}
