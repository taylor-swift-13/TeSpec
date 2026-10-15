#include "verification_stdlib.h"
void *cn_malloc(unsigned long n)
/*@ Require n == 4 && emp Ensure __return != 0 && undef_data_at(__return,int) */;
void cn_free_sized(void *p, unsigned long n)
/*@ Require n == 4 && undef_data_at(p,int) Ensure emp */;
int *malloc_int()
/*@ Require emp Ensure undef_data_at(__return,int) */
{
    return cn_malloc(sizeof(int));
}
void bad_free(int *p)

/*@ __tespec_entry Require
      (p == (16384)) && emp Ensure emp */
/*@ Require emp Ensure emp */
{
    cn_free_sized(p, sizeof(int));
}
int main()
/*@ Require emp Ensure __return == 0 && emp */
{
    int *p = malloc_int();
    bad_free(p);
  return 0;
}
