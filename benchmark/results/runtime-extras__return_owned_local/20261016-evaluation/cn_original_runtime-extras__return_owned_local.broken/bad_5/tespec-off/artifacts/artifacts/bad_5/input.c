#include "verification_stdlib.h"
void *cn_malloc(unsigned long n)
/*@ Require n == 4 && emp Ensure __return != 0 && undef_data_at(__return,unsigned int) */;
void cn_free_sized(void *p, unsigned long n)
/*@ Require n == 4 && undef_data_at(p,unsigned int) Ensure emp */;
unsigned int get (unsigned int *p)
/*@ With v Require data_at(p,unsigned int,v) Ensure __return == v && data_at(p,unsigned int,v) */
{
  return *p;
}
unsigned int **bad(unsigned int *p)

/*@ __tespec_entry With v Require
      (p == (4096)) && (v == (4294967295)) && data_at(p,unsigned int,v) Ensure data_at(p,unsigned int,v) * data_at(__return,unsigned int*,p) */
/*@ With v Require data_at(p,unsigned int,v) Ensure data_at(p,unsigned int,v) * data_at(__return,unsigned int*,p) */
{
    return &p;
}
int main()
/*@ Require emp Ensure __return == 0 && emp */
{
    unsigned int *x = cn_malloc(sizeof(unsigned int));
    *x = 5;
    unsigned int res = get(x);
    *x = 6;
    unsigned int **p = bad(x);
  return 0;
}
