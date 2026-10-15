#include "verification_stdlib.h"
void *cn_malloc(unsigned long n)
/*@ Require n == 4 && emp Ensure __return != 0 && undef_data_at(__return,unsigned int) */;
void cn_free_sized(void *p, unsigned long n)
/*@ Require n == 4 && undef_data_at(p,unsigned int) Ensure emp */;
unsigned int *mkref(unsigned int x)

/*@ __tespec_entry With v Require
      (x == (2147483647)) && (v == (2147483647)) && 0 <= v && v <= 4294967295 && x == v && emp Ensure data_at(__return,unsigned int,v) */
/*@ With v Require 0 <= v && v <= 4294967295 && x == v && emp Ensure data_at(__return,unsigned int,v) */
{
  unsigned int *p = cn_malloc(sizeof(unsigned int));
  *p = x;
  return p;
}
int main()
/*@ Require emp Ensure __return == 0 && emp */
{
    unsigned int *p = mkref(5);
  return 0;
}
