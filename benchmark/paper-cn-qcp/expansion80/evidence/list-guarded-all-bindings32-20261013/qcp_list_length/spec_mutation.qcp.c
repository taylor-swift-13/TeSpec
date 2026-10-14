#include "verification_stdlib.h"
#include "sll_layout32_def.h"
int length(struct list *p)
/*@ With (xs: list Z) Require Zlength(xs) <= 2147483647 && sll32(p,xs) Ensure __return == Zlength(xs) + 1 && sll32(p@pre,xs) */
{
   int n = 0;
   
   while (p) {
      
      n++;
      p = p -> next;
   }
   return n;
}
