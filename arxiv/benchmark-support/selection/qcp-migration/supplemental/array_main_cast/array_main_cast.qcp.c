#include "verification_stdlib.h"



#include "int_array_def.h"

int read (int *p, int n, int i)
/*@ With (l: list Z) Require 0 <= i && i < n && IntArray::full(p,n,l) Ensure __return == Znth(i,l,0) && IntArray::full(p,n,l) */
{
  return p[i];
}

int main()
/*@ Require emp Ensure __return == 0 && emp */
{
    int a[3] = { 0, 1, 2 };
    int zero = read((int*)&a, 3, 0);
/*@ Assert zero == 0 && zero == zero && IntArray::full(&a,3,cons(0,cons(1,cons(2,nil)))) */
    int *first = a;
/*@ Assert first == (&a) && zero == zero && first == first && IntArray::full(&a,3,cons(0,cons(1,cons(2,nil)))) */
    int one = read((int*)&a, 3, 1);
/*@ Assert one == 1 && zero == zero && first == first && one == one && IntArray::full(&a,3,cons(0,cons(1,cons(2,nil)))) */
    int *second = a + 1;
/*@ Assert second == (&a + 4) && zero == zero && first == first && one == one && second == second && IntArray::full(&a,3,cons(0,cons(1,cons(2,nil)))) */
    int two = read((int*)&a, 3, 2);
/*@ Assert two == 2 && zero == zero && first == first && one == one && second == second && two == two && IntArray::full(&a,3,cons(0,cons(1,cons(2,nil)))) */
    int *third = a + 2;
/*@ Assert third == (&a + 8) && zero == zero && first == first && one == one && second == second && two == two && third == third && IntArray::full(&a,3,cons(0,cons(1,cons(2,nil)))) */
  return 0;
}
