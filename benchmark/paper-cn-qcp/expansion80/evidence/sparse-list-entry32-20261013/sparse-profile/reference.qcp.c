#include "verification_stdlib.h"
#include "sll_layout32_def.h"
struct list *reverse(struct list *p)
/*@ With (xs: list Z) Require sll32(p,xs) Ensure sll32(__return,rev(xs)) */
{
   struct list * w = (void *) 0, * v = p;
   
   while (v) {
      
      struct list * t = v -> next;
      v -> next = w;
      w = v;
      v = t;
   }
   return w;
}
