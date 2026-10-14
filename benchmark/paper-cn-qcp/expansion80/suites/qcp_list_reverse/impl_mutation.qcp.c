#include "verification_stdlib.h"
#include "sll_def.h"
struct list *reverse(struct list *p)
/*@ With (xs: list Z) Require sll(p,xs) Ensure sll(__return,rev(xs)) */
{
   struct list * w = (void *) 0, * v = p;
   
   while (v) {
      
      struct list * t = v -> next;
      v -> next = (void *)0;
      w = v;
      v = t;
   }
   return w;
}
