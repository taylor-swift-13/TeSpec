#include "verification_stdlib.h"
void *cn_malloc(unsigned long n)
/*@ Require n == 4 && emp Ensure __return != 0 && undef_data_at(__return,unsigned int) */;
void cn_free_sized(void *p, unsigned long n)
/*@ Require n == 4 && undef_data_at(p,unsigned int) Ensure emp */;
unsigned int *mallocUnsignedInt()
/*@ Require emp Ensure __return != 0 && undef_data_at(__return,unsigned int) */
{
    return cn_malloc(sizeof(unsigned int));
}
void incr (unsigned int *p)
/*@ With v Require 0 <= v && v <= 4294967295 && data_at(p,unsigned int,v) Ensure data_at(p,unsigned int,(v+1)%4294967296) */
{
  unsigned int n = *p;
  unsigned int m = n+1;
  *p = m;
}
unsigned int *refUnsignedInt (unsigned int v)
/*@ With v0 Require 0 <= v0 && v0 <= 4294967295 && v == v0 && emp Ensure data_at(__return,unsigned int,v0) */
{
    unsigned int *res = mallocUnsignedInt();
    *res = v;
    return res;
}
unsigned int succ_using_incr_attempt(unsigned int n)

/*@ __tespec_entry With v Require
      (n == (4294967294)) && (v == (4294967294)) && 0 <= v && v <= 4294967295 && n == v && emp Ensure __return == (v+1)%4294967296 && emp */
/*@ With v Require 0 <= v && v <= 4294967295 && n == v && emp Ensure __return == (v+1)%4294967296 && emp */
{
  unsigned int *p = refUnsignedInt(n);
  incr(p);
  return *p;
}
