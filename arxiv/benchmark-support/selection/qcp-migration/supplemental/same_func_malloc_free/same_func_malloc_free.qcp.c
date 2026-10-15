#include "verification_stdlib.h"
void *cn_malloc(unsigned long n)
/*@ Require n == 4 && emp Ensure __return != 0 && undef_data_at(__return,unsigned int) */;
void cn_free_sized(void *p, unsigned long n)
/*@ Require n == 4 && undef_data_at(p,unsigned int) Ensure emp */;
unsigned int deref(unsigned int *p)
/*@ With v Require data_at(p,unsigned int,v) Ensure __return == v && data_at(p,unsigned int,v) */
{
  return *p;
}
int main()
/*@ Require emp Ensure __return == 0 && emp */
{
    unsigned int *p = cn_malloc(sizeof(unsigned int));
    *p = 5;
    unsigned int x = deref(p);
    cn_free_sized(p, sizeof(unsigned int));
  return 0;
}
