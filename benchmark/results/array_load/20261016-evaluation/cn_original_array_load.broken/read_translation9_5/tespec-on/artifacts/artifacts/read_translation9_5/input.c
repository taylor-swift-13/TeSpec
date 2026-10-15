#include "verification_stdlib.h"
#include "verification_stdlib.h"



#include "int_array_def.h"

int read (int *p, int n, int i)

/*@ __tespec_entry With (l: list Z) Require
      (p == (4096)) && (n == (4)) && (i == (1)) && (l == (cons(-7, cons(0, cons(7, cons(12, nil)))))) && 0 <= i && i < n && IntArray::full(p,n,l) Ensure __return == Znth(i,l,0) && IntArray::full(p,n,l) */
/*@ With (l: list Z) Require 0 <= i && i < n && IntArray::full(p,n,l) Ensure __return == Znth(i,l,0) && IntArray::full(p,n,l) */
{
  return p[i];
}
int verify_main(int *a)
/*@ With a0 Require a == a0 && IntArray::full(a0,3,cons(0,cons(1,cons(2,nil)))) Ensure __return == 0 && IntArray::full(a0,3,cons(0,cons(1,cons(2,nil)))) */
{
    
    int zero = read(a, 3, 0);
/*@ Assert a == a0 && zero == 0 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) && a == a && zero == zero */
    int *first = a;
/*@ Assert a == a0 && Znth(0,cons(0,cons(1,cons(2,nil))),0) == 0 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) && a == a && zero == zero && first == a0 */
    int one = read(a, 3, 1);
/*@ Assert a == a0 && one == 1 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) && a == a && zero == zero && first == a0 && one == one */
    int *second = a + 1;
/*@ Assert a == a0 && Znth(1,cons(0,cons(1,cons(2,nil))),0) == 1 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) && a == a && zero == zero && first == a0 && one == one && second == a0+4 */
    int two = read(a, 3, 2);
/*@ Assert a == a0 && two == 2 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) && a == a && zero == zero && first == a0 && one == one && second == a0+4 && two == two */
    int *third = a + 2;
/*@ Assert a == a0 && Znth(2,cons(0,cons(1,cons(2,nil))),0) == 2 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) && a == a && zero == zero && first == a0 && one == one && second == a0+4 && two == two && third == a0+8 */
  return 0;
}
