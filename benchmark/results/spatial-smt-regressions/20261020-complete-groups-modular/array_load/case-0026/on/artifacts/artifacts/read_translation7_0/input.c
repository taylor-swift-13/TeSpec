#include "verification_stdlib.h"


#include "int_array_def.h"

int read (int *p, int n, int i)

/*@ __tespec_entry With (l: list Z) Require
      (p == (4096)) && (n == (1)) && (i == (0)) && (l == (cons(0, nil))) && 0 <= i && i < n && IntArray::full(p,n,l) Ensure __return == Znth(i,l,0) && IntArray::full(p,n,l) */
/*@ With (l: list Z) Require 0 <= i && i < n && IntArray::full(p,n,l) Ensure __return == Znth(i,l,0) && IntArray::full(p,n,l) */
{
  return p[i];
}

int main()
/*@ Require emp Ensure __return == 0 && emp */
{
    int a[3] = { 0, 1, 2 };
    int zero = read((int*)&a, 3, 0) /*@ where l = cons(0,cons(1,cons(2,nil))) */;
/*@ Assert zero == 0 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) */
    int *first = a;
/*@ Assert data_at(first,int,0) * IntArray::missing_i(a,0,0,3,cons(0,cons(1,cons(2,nil)))) */
    int one = read((int*)&a, 3, 1) /*@ where l = cons(0,cons(1,cons(2,nil))) */;
/*@ Assert one == 1 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) */
    int *second = a + 1;
/*@ Assert data_at(second,int,1) * IntArray::missing_i(a,1,0,3,cons(0,cons(1,cons(2,nil)))) */
    int two = read((int*)&a, 3, 2) /*@ where l = cons(0,cons(1,cons(2,nil))) */;
/*@ Assert two == 2 && IntArray::full(a,3,cons(0,cons(1,cons(2,nil)))) */
    int *third = a + 2;
/*@ Assert data_at(third,int,2) * IntArray::missing_i(a,2,0,3,cons(0,cons(1,cons(2,nil)))) */
  return 0;
}
