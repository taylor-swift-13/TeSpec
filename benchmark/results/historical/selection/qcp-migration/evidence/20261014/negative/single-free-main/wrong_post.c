#include "verification_stdlib.h"


void *cn_malloc(unsigned long size)
/*@ Require size == sizeof(unsigned int) && emp
    Ensure __return != 0 && undef_data_at(__return,unsigned int) */;
void cn_free_sized(void *p, unsigned long size)
/*@ Require size == sizeof(unsigned int) && undef_data_at(p,unsigned int)
    Ensure emp */;


unsigned int deref(unsigned int *p)
/*@ With v0 Require data_at(p,unsigned int,v0) Ensure __return == v0 && data_at(p,unsigned int,v0) */
{
  return *p;
}

int main()
/*@ Require emp Ensure (emp) && 0 == 1 */
{
    unsigned int *p = cn_malloc(sizeof(unsigned int));
    *p = 5;
    unsigned int x = deref(p);
    cn_free_sized(p, sizeof(unsigned int));
  return 0;
}
