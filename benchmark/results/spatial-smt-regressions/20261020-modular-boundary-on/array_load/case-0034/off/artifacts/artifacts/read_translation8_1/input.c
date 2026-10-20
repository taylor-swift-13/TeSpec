#include "verification_stdlib.h"



#include "int_array_def.h"

int read (int *p, int n, int i)

/*@ __tespec_entry With (l: list Z) Require
      (p == (4096)) && (n == (1)) && (i == (0)) && (l == (cons(-2147483648, nil))) && 0 <= i && i < n && IntArray::full(p,n,l) Ensure __return == Znth(i,l,0) && IntArray::full(p,n,l) */
/*@ With (l: list Z) Require 0 <= i && i < n && IntArray::full(p,n,l) Ensure __return == Znth(i,l,0) && IntArray::full(p,n,l) */
{
  return p[i];
}
int verify_main(int *a)
/*@ Require IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) Ensure __return == 0 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) */
{
    
    int zero = read(a, 3, 0);
/*@ Assert zero == 0 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) && a == a && zero == zero */
    int *first = a;
/*@ Assert Znth(0,cons(0,cons(1,cons(2,nil))),0) == 0 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) && a == a && zero == zero && first == first */
    int one = read(a, 3, 1);
/*@ Assert one == 1 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) && a == a && zero == zero && first == first && one == one */
    int *second = a + 1;
/*@ Assert Znth(1,cons(0,cons(1,cons(2,nil))),0) == 1 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) && a == a && zero == zero && first == first && one == one && second == second */
    int two = read(a, 3, 2);
/*@ Assert two == 2 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) && a == a && zero == zero && first == first && one == one && second == second && two == two */
    int *third = a + 2;
/*@ Assert Znth(2,cons(0,cons(1,cons(2,nil))),0) == 2 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) && a == a && zero == zero && first == first && one == one && second == second && two == two && third == third */
  return 0;
}
